# System Design Deep Dive -- AVFoundation Composition

@Metadata {
  @TitleHeading("Review System Design Deep Dive -- AVFoundation Composition")
  @PageImage(purpose: icon, source: "system-design-deep-dive-avfoundation-composition-icon.codex", alt: "System Design Deep Dive AVFoundation Composition icon")
  @PageImage(purpose: card, source: "system-design-deep-dive-avfoundation-composition-card.codex", alt: "System Design Deep Dive AVFoundation Composition card")
}

@Image(source: "system-design-deep-dive-avfoundation-composition-hero.codex", alt: "System Design Deep Dive AVFoundation Composition hero")

This deep dive covers how to **merge multiple audio and video sources** on iOS using
`AVFoundation`, with a focus on system design patterns you can reuse across products:

- `AVMutableComposition` as a **timeline** of media.
- Multiple **audio layers** (original audio, music, voice-over).
- Multiple **video tracks** (concatenation, picture-in-picture, overlays).
- Export to a single shareable file with `AVAssetExportSession`.

Use this when you get questions like:

- “How would you stitch together several clips with different audio layers?”
- “How do you build a RenderKit-style export pipeline for your app?”

---

## 45-Minute Tour Script

0:00 - 4:00: Frame the problem (compose multiple media sources, preserve quality, keep UX fast).

4:00 - 9:00: Architecture overview.

- Use the pipeline sketch in section 1.
- Name assets, composition, optional mixes, and export.

9:00 - 15:00: Concatenation flow.

- Use section 2; call out timeline construction and ordering.

15:00 - 20:00: Audio layers and mixing.

- Use section 3; explain ducking and layered tracks.

20:00 - 25:00: Video tracks and overlays.

- Use section 4; explain transforms and layering.

25:00 - 30:00: Export pipeline.

- Use section 5; talk presets, progress, and background export.

30:00 - 36:00: Scaling and performance.

- Queue exports, cap concurrency, and cache intermediates on disk.
- Call out memory pressure and file size tradeoffs.

36:00 - 40:00: Observability.

- Track export failures, durations, and device resource usage.

40:00 - 45:00: Privacy and failure modes.

- Emphasize on-device processing, permissions, and safe fallbacks.
- Take questions and adjust the design.

## Mapping to the Generic Outline

### Problem Framing

- Multi-source media composition with strict UX expectations and device constraints.

### Architecture

- Assets into a composition timeline, optional audio/video mixes, then export.
- Composition layer is a pure media pipeline, independent of higher-level features.

### Data Flow

- Ingest assets, build timeline, apply transforms, and export to a file.
- Split read flow (assets) from write flow (export output).

### Caching and Offline

- Store intermediates on disk; clean up after export.
- Define cache limits for large media sessions.

### Scaling

- Serialize heavy exports, cap concurrency, and batch small renders.
- Use background tasks to avoid blocking the UI.

### Observability

- Export duration, error rate, canceled exports, and device resource use.
- Track progress events for UX and debugging.

### Privacy and Safety

- Keep media on device unless the user explicitly shares.
- Apply permission checks before accessing photos or mic.

### Failure Modes

- Export failure, out-of-space, or corrupt input assets.
- Provide retry, partial recovery, and clear user feedback.

## 1. Architecture Overview

Conceptual pipeline:

```text
 [Video files]  [Audio files]
      |               |
   AVURLAsset    AVURLAsset
      \           /
       \         /
    AVMutableComposition (timeline: video+audio tracks)
            |
      [Optional]
   AVMutableVideoComposition (overlays, transforms)
   AVMutableAudioMix          (levels, ramps)
            |
   AVAssetExportSession  ->  Final MP4/MOV
```

Pieces:

- `AVURLAsset`:
  - Wraps a media file on disk (video or audio).
- `AVMutableComposition`:
  - Owns a set of `AVMutableCompositionTrack`s:
    - `.video` tracks for video.
    - `.audio` tracks for audio.
  - You **insert time ranges** from assets into these tracks at specific times.
- `AVMutableVideoComposition` (optional):
  - Configures how frames are composed:
    - Orientation, scaling, picture-in-picture, overlays.
- `AVMutableAudioMix` (optional):
  - Controls per-track audio levels and ramps (ducking, fades).
- `AVAssetExportSession`:
  - Runs the export to a final file (`.mp4`, `.mov`, etc.).

System design framing:

- The composition is your **render graph** for the final file.
- External concerns (LLM/TTS, real-time pipelines) produce:
  - Audio files (TTS voice-over, music stems).
  - Video files (recorded sessions, avatar renders).
- The composition layer **does not know about AI**; it only merges media.

---

## 2. Concatenating Multiple Video Clips (with Audio)

Goal:

- Given several video files, create a single video with:
  - Video clips played **back-to-back**.
  - Original audio retained.

Key points:

- Create a single `.video` and `.audio` track in the composition.
- For each input asset:
  - Insert its video and audio time ranges at the current timeline time.

Code sketch:

```swift
import AVFoundation

func makeVideoComposition(from videoURLs: [URL]) throws -> AVMutableComposition {
  let composition = AVMutableComposition()

  guard
    let videoTrack = composition.addMutableTrack(
      withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid),
    let audioTrack = composition.addMutableTrack(
      withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
  else {
    throw NSError(
      domain: "Composition", code: 1,
      userInfo: [
        NSLocalizedDescriptionKey:
          "Unable to create composition tracks"
      ])
  }

  var currentTime = CMTime.zero

  for url in videoURLs {
    let asset = AVURLAsset(url: url)
    guard
      let assetVideo = asset.tracks(withMediaType: .video).first
    else { continue }

    let timeRange = CMTimeRange(start: .zero, duration: asset.duration)

    try videoTrack.insertTimeRange(timeRange, of: assetVideo, at: currentTime)

    if let assetAudio = asset.tracks(withMediaType: .audio).first {
      try audioTrack.insertTimeRange(timeRange, of: assetAudio, at: currentTime)
    }

    currentTime = currentTime + asset.duration
  }

  return composition
}
```

In an interview answer, explain:

- You treat each clip as a **segment** in a shared timeline.
- You keep start times explicit (`currentTime`) so you can later:
  - Insert transitions.
  - Align additional audio layers.

---

## 3. Multiple Audio Layers: Original, Music, and Voice-over

Goal:

- Start from a base composition (for example, from the function above).
- Add:
  - Background music (looped or trimmed).
  - Voice-over or narration (for example, from a TTS generator).
- Control levels (music low, voice full) and ducking.

Pattern:

- Add one audio composition track per **layer**:
  - Base audio (already in the composition).
  - Music track.
  - Voice track.
- Use `AVMutableAudioMixInputParameters`:
  - `setVolume(_:at:)` for static levels.
  - `setVolumeRamp(fromStartVolume:toEndVolume:timeRange:)` for fades/ducking.

Code sketch:

```swift
func addAudioLayers(
  to composition: AVMutableComposition,
  musicURL: URL,
  voiceOverURL: URL,
  duration: CMTime
) throws -> AVAudioMix {
  let musicAsset = AVURLAsset(url: musicURL)
  let voiceAsset = AVURLAsset(url: voiceOverURL)

  guard
    let musicTrack = composition.addMutableTrack(
      withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid),
    let voiceTrack = composition.addMutableTrack(
      withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
  else {
    throw NSError(
      domain: "Composition", code: 2,
      userInfo: [
        NSLocalizedDescriptionKey:
          "Unable to create extra audio tracks"
      ])
  }

  if let musicAssetTrack = musicAsset.tracks(withMediaType: .audio).first {
    let musicTimeRange = CMTimeRange(start: .zero, duration: min(musicAsset.duration, duration))
    try musicTrack.insertTimeRange(musicTimeRange, of: musicAssetTrack, at: .zero)
  }

  if let voiceAssetTrack = voiceAsset.tracks(withMediaType: .audio).first {
    let voiceTimeRange = CMTimeRange(start: .zero, duration: min(voiceAsset.duration, duration))
    try voiceTrack.insertTimeRange(voiceTimeRange, of: voiceAssetTrack, at: .zero)
  }

  let musicInput = AVMutableAudioMixInputParameters(track: musicTrack)
  musicInput.setVolume(0.3, at: .zero)  // background music lower

  let voiceInput = AVMutableAudioMixInputParameters(track: voiceTrack)
  voiceInput.setVolume(1.0, at: .zero)  // voice-over full volume

  // Optional: volume ramps for ducking.
  let start = CMTime(seconds: 1, preferredTimescale: 600)
  let end = CMTime(seconds: 3, preferredTimescale: 600)
  let range = CMTimeRange(start: start, duration: end - start)

  musicInput.setVolumeRamp(fromStartVolume: 0.3, toEndVolume: 0.1, timeRange: range)
  voiceInput.setVolumeRamp(fromStartVolume: 0.0, toEndVolume: 1.0, timeRange: range)

  let audioMix = AVMutableAudioMix()
  audioMix.inputParameters = [musicInput, voiceInput]

  return audioMix
}
```

System design angle:

- You can treat audio layers as **independent tracks** that align on the same timeline.
- This maps well to:
  - TTS voice-over generated by an LLM-based system.
  - Background music chosen based on mood/scene.

---

## 4. Multiple Video Tracks and Overlays

`AVMutableVideoComposition` lets you define how frames from different tracks are combined.

Common cases:

- **Orientation fix**:
  - Apply `preferredTransform` so portrait videos render correctly.
- **Picture-in-picture**:
  - Secondary video scaled and placed in a corner.
- **Watermarks / captions**:
  - Overlays drawn via `CALayer` backing.

High-level sketch (picture-in-picture):

```text
 [Main video track]  ------------------------------+
                                                   |
 [Secondary video] -> scaled/positioned ---------->+-> final frame
 [Overlay layer (text, logo)] -------------------->+
```

Basic setup for a single video track:

```swift
func makeVideoComposition(
  for composition: AVMutableComposition,
  videoTrack: AVCompositionTrack,
  renderSize: CGSize
) -> AVMutableVideoComposition {
  let instruction = AVMutableVideoCompositionInstruction()
  instruction.timeRange = CMTimeRange(start: .zero, duration: composition.duration)

  let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)

  let transform = videoTrack.preferredTransform
  layerInstruction.setTransform(transform, at: .zero)

  instruction.layerInstructions = [layerInstruction]

  let videoComposition = AVMutableVideoComposition()
  videoComposition.instructions = [instruction]
  videoComposition.renderSize = renderSize
  videoComposition.frameDuration = CMTime(value: 1, timescale: 30)

  return videoComposition
}
```

For multi-video layouts, you:

- Create multiple `AVMutableVideoCompositionLayerInstruction`s.
- Compute transforms (scale, translation) for each track.
- Optionally, overlay text or logos with `CALayer` trees assigned to
  `AVVideoCompositionCoreAnimationTool`.

---

## 5. Exporting the Composition

Once you have:

- `AVMutableComposition` (video + audio tracks).
- Optional `AVMutableVideoComposition`.
- Optional `AVAudioMix`.

Use `AVAssetExportSession`:

```swift
func exportComposition(
  _ composition: AVMutableComposition,
  videoComposition: AVMutableVideoComposition?,
  audioMix: AVAudioMix?,
  outputURL: URL,
  presetName: String = AVAssetExportPresetHighestQuality
) async throws {
  guard let exporter = AVAssetExportSession(asset: composition, presetName: presetName) else {
    throw NSError(
      domain: "Composition", code: 3,
      userInfo: [
        NSLocalizedDescriptionKey:
          "Unable to create exporter"
      ])
  }

  exporter.outputURL = outputURL
  exporter.outputFileType = .mp4
  exporter.shouldOptimizeForNetworkUse = true
  exporter.videoComposition = videoComposition
  exporter.audioMix = audioMix

  try await withCheckedThrowingContinuation { continuation in
    exporter.exportAsynchronously {
      if let error = exporter.error {
        continuation.resume(throwing: error)
      } else {
        continuation.resume()
      }
    }
  }
}
```

Interview talking points:

- Explain presets (`AVAssetExportPresetHighestQuality`, `AVAssetExportPresetMediumQuality`, etc.).
- Mention:
  - Exporting in the background and reporting progress.
  - Hardware acceleration via `VideoToolbox` under the hood.
  - Tradeoffs between quality, file size, and battery.

---

## 6. Applying This in AI/LLM + Graphics Scenarios

In AI-heavy products (for example, avatar chats):

- The **AI pipeline** produces:
  - Audio files for bot speech (TTS).
  - Possibly rendered avatar video segments from Unity/RenderKit.
- The **composition pipeline** is responsible for:
  - Aligning these on a timeline.
  - Adding music, SFX, and overlays.
  - Exporting to a shareable file.

Example story you can tell:

- “We record a Cantina session as a set of segments:
  - Rendered avatar video per turn.
  - Corresponding TTS output file.
  - Optional user camera track.
  - Background music chosen based on mood.
- Then we build an `AVMutableComposition` that:
  - Concatenates avatar video segments.
  - Layers:
    - Original TTS audio.
    - Background music at low volume, ducked under speech.
  - Exports to a single `.mp4` that users can share.”

The key is to show you understand:

- `AVFoundation` as a **compositing engine**, not just a playback API.
- How to reason about:
  - Multiple tracks.
  - Level control.
  - Export performance and UX.
