@PageImage(purpose: card, source: "unity-ai-llm-graphics-guide-card.codex", alt: "Placeholder card")
@PageImage(purpose: icon, source: "unity-ai-llm-graphics-guide-icon.codex", alt: "Placeholder icon")
# Unity + AI/LLM Graphics and Video Guide

@Image(source: "unity-ai-llm-graphics-guide-hero.codex", alt: "Unity + AI LLM graphics and video guide hero")

This note collects patterns for integrating **Unity** with **AI/LLM systems** in
graphics- and video-heavy apps, with a focus on:

- Real-time **voice + avatar** experiences.
- **RenderKit-style** video compositing on iOS.
- Patterns that generalize to other engines (for example, **Unreal Engine**).

Use it as a prep sheet for system design and graphics/engine interviews where you need to talk
through **LLM + media** integration.

---

## 1. High-level Architecture Patterns

Think of the system as four cooperating layers:

```text
[Client UI]   SwiftUI / UIKit around Unity/Unreal view
     |
[Engine]      Unity or Unreal (avatars, scenes, animation)
     |
[Media I/O]   AVFoundation / WebRTC / RenderKit / encoders-decoders
     |
[AI services] STT, LLM, TTS, tools, storage
```

At a high level:

- The **engine** (Unity/Unreal) is responsible for:
  - Rendering avatars and scenes in real time.
  - Running animation state machines, blendshapes, VFX.
- The **media layer** deals with:
  - Audio capture (`AVAudioEngine`), playback, and routing.
  - Optional camera capture (`AVCaptureSession`).
  - Video compositing/recording (`RenderKit`, `AVAssetWriter`, `AVMutableComposition`).
- The **AI services**:
  - Convert **speech to text** (STT).
  - Run **LLM** logic and tools.
  - Convert **text to speech** (TTS) plus **viseme/phoneme** timings.

Key separation: **Unity/Unreal should not know about the LLM directly**. It should consume
**high-level events** like “bot X is speaking with this viseme timeline” or “user is now active
speaker,” not call HTTP endpoints or embed AI clients.

---

## 2. Real-time Voice + Avatar Loop

Core pipeline:

```text
Mic -> STT -> LLM/tools -> TTS (+visemes) -> Engine (avatars) + Audio output
```

Typical architecture:

- **Audio capture**:
  - `AVAudioSession` configured with `.playAndRecord` and voice-processing options.
  - `AVAudioEngine` tap on the input node to capture PCM frames.
  - 20 ms frames encoded as Opus or sent raw PCM over `WebRTC`/WebSocket.
- **STT**:
  - Cloud STT (Whisper, provider API) for accuracy.
  - On-device STT (`Speech` framework or embedded model) for low latency.
  - Hybrid: on-device for fast interim results, cloud for final corrections.
- **LLM**:
  - Receives final transcript + context + persona.
  - Streams tokens for low perceived latency.
  - May call tools (for example, knowledge lookups) before answering.
- **TTS + visemes**:
  - TTS produces an audio stream plus either:
    - **Phoneme or viseme timestamps**, or
    - Word-level timestamps that can be mapped to mouth shapes.
- **Engine integration**:
  - The engine receives:
    - The audio (or a handle to platform playback).
    - A **viseme timeline**: time → blendshape weights.
  - It drives:
    - Mouth blendshapes.
    - Head/eye/body animations for listening and emphasis.

Latency budget (example targets):

| Stage                       | Target (ms)   |
| --------------------------- | ------------: |
| Mic → STT final             |    200–400    |
| STT → LLM first tokens      |    100–300    |
| LLM → TTS first audio chunk |    150–300    |
| Audio start → avatar motion |     50–150    |

Aim for **< 2 s** end-to-end (user stop → avatar speech complete) and **< 500 ms** to first
bot audio in the happy path.

---

## 3. Unity Integration Patterns (iOS)

### 3.1 Unity As a Library (Embedding in iOS)

Common setup:

- Unity runs as a **subsystem** embedded into a native iOS app (Unity as a Library).
- The Swift/Objective-C side:
  - Owns app lifecycle, navigation, permissions, etc.
  - Presents a `UIViewController` with a Unity view when needed (chat/scene screens).
- The Unity side:
  - Owns scene graphs, avatars, lighting, effects.
  - Exposes methods for:
    - Updating avatar state (speaking, idle, thinking).
    - Accepting viseme timelines and control messages.

Bridge patterns:

- **Native → Unity**:
  - `UnitySendMessage("GameObjectName", "MethodName", jsonPayload)`.
  - Or native plugins binding into C# methods with structured data.
- **Unity → Native**:
  - Native plugin calls into Swift/ObjC.
  - Callbacks for:
    - Scene loaded.
    - Animation events (for example, gesture completion).
    - User interactions (for example, tapping a bot).

Guiding rules:

- Keep **Unity messages high-level**:
  - “Bot A: start speech with this viseme timeline” rather than raw bytes of audio.
- Avoid calling **LLM APIs from C#** in the engine:
  - Instead, treat Unity as a view layer that renders decisions made by the iOS/AI stack.

### 3.2 Performance and Lifecycle

Key issues:

- **Memory and assets**:
  - Large textures, meshes, and audio assets.
  - Unity manages its own heap on top of iOS memory limits.
- **Lifecycle**:
  - Initializing Unity is relatively heavy.
  - Unloading Unity frees memory but has a cost to re-initialize.

Patterns:

- Initialize Unity:
  - On app cold start, if the product is “always-on 3D.”
  - Or on first entry to a “3D chat” screen, with a small loading experience.
- Unload Unity:
  - When leaving heavy 3D contexts for a while (for example, going back to a feed).
  - When receiving memory pressure or backgrounding if 3D is not needed.
- Tune quality:
  - Lower render scale, simpler shaders, fewer real-time lights for mobile.
  - Use level-of-detail (LOD) on characters and environments.

Frame-rate considerations:

- Target **30 or 60 FPS** for avatars.
- Avoid:
  - Heavy allocations on UI/main thread.
  - Blocking tasks in Unity callbacks that need to stay real time.

---

## 4. RenderKit-style Video Capture and Compositing

Even when the experience is real-time, many apps need to **record** or export a stylized video:

- User chats with an AI avatar.
- The system records a side-by-side or picture-in-picture layout.
- The recording can be edited or shared later.

### 4.1 Live vs Offline Rendering

Two main modes:

1. **Live compositing**:
   - Render a Unity view (avatars) into a view or texture.
   - Composite UI elements (captions, stickers, UI chrome) via `RenderKit`/Metal.
   - Record audio and video in real time via `AVAssetWriter`.
2. **Offline rendering**:
   - Save timeline data (camera paths, animations, viseme sequences, audio).
   - Re-run a deterministic render at higher quality or resolution in the background or on a server.

Tradeoffs:

- Live compositing:
  - Pros: immediate, matches what the user saw.
  - Cons: tied to real-time performance; lower quality under thermal or frame drops.
- Offline rendering:
  - Pros: can use slower, higher-quality settings; rerender in case of glitches.
  - Cons: delayed availability; must ensure deterministic playback from recorded events.

### 4.2 iOS Video Composition Building Blocks

Key APIs (Unity + RenderKit adjacent):

- `AVAssetWriter`:
  - For writing video + audio to a file in real time.
  - Takes encoded frames (for example, H.264 via `VideoToolbox`).
- `AVMutableComposition`:
  - For building a timeline with multiple audio and video tracks.
  - Allows:
    - Multiple clips, transitions.
    - Overlaid audio (music, SFX, voices).
- `AVVideoComposition` / `AVVideoCompositing`:
  - For custom compositing pipelines.
  - Blend rendered textures from Unity with other sources.

RenderKit-style behavior:

- Capture Unity’s output as:
  - A `CAMetalLayer` or texture, or
  - A pixel buffer from an offscreen render target.
- Feed it into:
  - A Metal pipeline for filters, overlays, text.
  - Or an `AVAssetWriterInputPixelBufferAdaptor` for direct video writing.
- Combine with audio:
  - Bot voices (TTS output).
  - User mic (if included).
  - Background music or effects.

Pattern for offline/export:

```text
Unity / Engine renders into offscreen target
    |
    v
RenderKit / Metal pipeline (effects, UI overlays)
    |
    v
AVAssetWriter (video track) + audio tracks
    |
    v
Final MP4 / HEVC file for sharing
```

---

## 5. Lip-sync and Animation Control

Lip-sync is a central question in Unity + AI interviews.

Two main approaches:

### 5.1 Text-driven Lip-sync (Preferred with TTS)

Pipeline:

- TTS engine returns:
  - Audio.
  - Phoneme or viseme sequence with timestamps.
- Native side:
  - Maps phonemes → viseme IDs (mouth shapes).
  - Produces a timeline: `(time, viseme, weight)`.
- Unity side:
  - Receives the timeline and:
    - Applies blendshape weights to the avatar’s face.
    - Optionally adds head/eye motion synced to prosody.

Pros:

- Very accurate alignment (TTS knows exactly what it generated).
- Easy to keep in sync even with jitter: drive animation from audio clock + timeline.

### 5.2 Audio-driven Lip-sync

Pipeline:

- Take audio stream (for example, from TTS or recorded).
- Run a phoneme/viseme estimator:
  - Unity plugin (e.g., OVRLipSync-style).
  - External ML model.
- Generate per-frame viseme weights from the audio waveform.

Pros:

- Works for arbitrary voice audio (not just TTS).
Cons:

- Slightly more latency due to analysis.
- Less precise than direct TTS phoneme export.

### 5.3 Animation Layering

Lip-sync is just one layer:

- **Base pose / idle**:
  - Neutral or low-motion stance when not speaking.
- **Lip-sync**:
  - Blendshape layer for mouth and sometimes jaw.
- **Gesture**:
  - Head nods, hand motions, eye focus based on intent.
- **Emotional state**:
  - Blendshapes for smiles/frowns, brow movement, etc., based on sentiment or context.

Unity can implement this via:

- Animator state machines and layers.
- Additive animation clips.
- Direct control of blendshape weights each frame.

In interviews, stress that you **separate concerns**:

- Lip-sync from TTS phonemes.
- Gesture/emotion from higher-level context (LLM sentiment or conversation state).

---

## 6. Multi-engine Considerations (Unity vs Unreal)

The patterns above are engine-agnostic:

- **Rendering responsibility**:
  - Both Unity and Unreal:
    - Render avatars.
    - Accept external timing/animation data.
- **Embedding**:
  - Both engines can run:
    - Embedded inside native iOS shells.
    - In standalone apps with native bridges.
- **Data flow**:
  - Neither engine should consume raw LLM/HTTP calls directly.
  - Both should be fed:
    - High-level animation and timeline data.
    - Events about who is speaking, emotional state, etc.

Unreal-specific nuances (at a high level):

- Uses **Blueprints** and C++ instead of C# for game logic.
- Similar patterns:
  - Blueprint/C++ functions to accept viseme timelines and control states.
  - Native plugins for bridging to Swift/Objective-C on iOS.

In interview answers:

- Emphasize that you:
  - **Abstract the engine** behind an interface.
  - Treat the engine as a **rendering and animation runtime**, not an AI platform.

---

## 7. Failure Modes and Performance Pitfalls

Common problems and mitigations:

- **Audio/video desync**:
  - Cause: network jitter, TTS variations, dropped frames.
  - Fix:
    - Drive animation from a single **audio clock**.
    - Periodically resync to timestamps; clamp drift.
- **Low frame rate / jank**:
  - Cause: heavy Unity scenes, too many dynamic objects, expensive shaders.
  - Fix:
    - Reduce visual complexity, use baked lighting, fewer dynamic shadows.
    - Move CPU-heavy work (parsing, AI calls) off main/game threads.
- **Thermal issues**:
  - Cause: long-running, high-load sessions.
  - Fix:
    - Lower frame rate when device heats up.
    - Pause non-essential effects and background tasks.
- **Memory pressure / OS kills**:
  - Cause: large Unity heap, many textures/audio assets.
  - Fix:
    - Unload unused scenes and assets.
    - Consider unloading the engine when user is outside 3D features.

For AI/LLM-specific failures:

- STT fails or is slow:
  - Show text input fallback; allow user to type.
  - Reuse partial transcripts where possible.
- LLM slow:
  - Show “thinking” state and streaming text.
  - Cut responses via max tokens or explicit `<END_OF_TURN>` markers.
- TTS slow/failing:
  - Use text-only bubbles as fallback.
  - Retry with a simpler/backup voice model.

---

## 8. Interview Framing Tips

When asked about Unity + AI/LLM + graphics:

- Start with:

  > “At a high level, I’d split this into:  
  > media capture → AI pipeline (STT/LLM/TTS) → engine rendering → optional recording/compositing.”

- Then choose a **zoom level**:
  - System architecture (services and flows).
  - Engine integration (Unity bridging and animation).
  - iOS/media specifics (AVFoundation, RenderKit, composition).
- Always surface:
  - **Latency budgets** and how you pipeline.
  - **Degradation paths** for poor networks or heavy load.
  - **Testing/observability**: how you know it’s working or failing.

Use this guide as a checklist to ensure you hit **graphics**, **video**, and **AI** angles
coherently, no matter how the question is phrased.
