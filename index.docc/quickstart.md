# Swift Interview Guide — Quick Preview

@Metadata {
  @PageImage(purpose: icon, source: "quickstart-icon.codex", alt: "Swift Interview Guide Quick Preview icon")
  @PageImage(purpose: card, source: "quickstart-card.codex", alt: "Swift Interview Guide Quick Preview card")
}

@Image(source: "quickstart-hero.codex", alt: "Swift Interview Guide Quick Preview hero")

Serve this DocC bundle locally with the in‑process preview CLI.

Prerequisites

- macOS 14+
- Build the preview CLI once:

```bash
swift build --package-path code/mono/apple/spm/clis/docc-wrkstrm-cli -c release
```

Recommended: render the bundle

```bash
xcrun docc convert \
  code/mono/docc/private/host/local/swift-interview-guide.docc \
  --fallback-display-name "Swift Interview Guide" \
  --fallback-bundle-identifier "com.todo3.job-hunting.swift-interview-guide" \
  --fallback-bundle-version "1.0.0" \
  --output-path code/mono/docc/private/host/local/swift-interview-guide.docc/.docc-build
```

Serve (foreground)

```bash
code/mono/apple/spm/clis/docc-wrkstrm-cli/.build/release/docc-wrkstrm serve \
  --bundle code/mono/docc/private/host/local/swift-interview-guide.docc \
  --host 127.0.0.1 --port 8101 --stay
```

Open: <http://127.0.0.1:8101/documentation/swift-interview-guide>

Serve (background)

```bash
nohup code/mono/apple/spm/clis/docc-wrkstrm-cli/.build/release/docc-wrkstrm serve \
  --bundle code/mono/docc/private/host/local/swift-interview-guide.docc \
  --host 127.0.0.1 --port 8101 --stay --quiet \
  > .clia/tmp/docc-wrkstrm-swiftly.log 2>&1 &
```

Stop

- Ctrl+C in foreground, or:
- `pkill -f "docc-wrkstrm serve --bundle .*swift-interview-guide\.docc"`
