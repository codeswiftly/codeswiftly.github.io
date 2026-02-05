# Swift Interview Guide — DocC Preview



Quick steps to build and serve this DocC bundle locally with the in‑process preview CLI.

## Prerequisites

- macOS 14+
- Xcode toolchain installed (`xcrun` available)

## 1) Build the Preview CLI (Once)

```bash
swift build \
  --package-path code/mono/apple/spm/clis/docc-wrkstrm-cli \
  -c release
```

## 2) Render the Docs (Recommended)

```bash
xcrun docc convert \
  code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc \
  --fallback-display-name "Swift Interview Guide" \
  --fallback-bundle-identifier "me.rismay.swift.interview.guide" \
  --fallback-bundle-version "1.0.0" \
  --output-path code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/.docc-build
```

## 3) Serve with the CLI

```bash
code/mono/apple/spm/clis/docc-wrkstrm-cli/.build/release/docc-wrkstrm serve \
  --bundle code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc \
  --host 127.0.0.1 \
  --port 8101 \
  --stay
```

<http://127.0.0.1:8101/documentation/swift-interview-guide>

## Quickstart (One Line, Background)

```bash
nohup code/mono/apple/spm/clis/docc-wrkstrm-cli/.build/release/docc-wrkstrm serve \
  --bundle code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc \
  --host 127.0.0.1 --port 8101 --stay --quiet \
  > .clia/tmp/docc-wrkstrm-swiftly.log 2>&1 &
echo "http://127.0.0.1:8101/documentation/swift-interview-guide"
```

## Stop the Server

- Press Ctrl+C in the terminal where it is running, or:
- `pkill -f "docc-wrkstrm serve --bundle code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc"`

Notes

- The CLI serves the rendered site from `.docc-build` when present. If you skip step 2, the server
  attempts to serve a previously rendered output (if available).
