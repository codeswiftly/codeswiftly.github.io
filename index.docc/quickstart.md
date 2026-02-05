# Swift Interview Guide — Quick Preview



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
  code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc \
  --fallback-display-name "Swift Interview Guide" \
  --fallback-bundle-identifier "com.codeswiftly.swift-interview-guide" \
  --fallback-bundle-version "1.0.0" \
  --output-path code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/.docc-build
```

Serve (foreground)

```bash
code/mono/apple/spm/clis/docc-wrkstrm-cli/.build/release/docc-wrkstrm serve \
  --bundle code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc \
  --host 127.0.0.1 --port 8101 --stay
```

Open: <http://127.0.0.1:8101/documentation/swift-interview-guide>

Serve (background)

```bash
nohup code/mono/apple/spm/clis/docc-wrkstrm-cli/.build/release/docc-wrkstrm serve \
  --bundle code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc \
  --host 127.0.0.1 --port 8101 --stay --quiet \
  > .clia/tmp/docc-wrkstrm-swiftly.log 2>&1 &
```

Stop

- Ctrl+C in foreground, or:
- `pkill -f "docc-wrkstrm serve --bundle .*swift-interview-guide\.docc"`
