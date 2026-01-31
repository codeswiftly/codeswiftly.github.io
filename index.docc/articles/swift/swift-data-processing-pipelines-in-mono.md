@PageImage(purpose: card, source: "swift-swift-data-processing-pipelines-in-mono-card.codex", alt: "Placeholder card")
@Image(source: "swift-swift-data-processing-pipelines-in-mono-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "swift-swift-data-processing-pipelines-in-mono-icon.codex", alt: "Placeholder icon")
# Swift Data Processing Pipelines in `Code/Mono`

@Metadata {
  @TitleHeading("Review Swift Data Processing Pipelines in `Code/Mono`")
    @PageColor(blue)
  @PageImage(purpose: icon, source: "swift-data-processing-pipelines-in-mono-icon.codex", alt: "Swift Data Processing Pipelines in Code Mono icon")
  @PageImage(purpose: card, source: "swift-data-processing-pipelines-in-mono-card.codex", alt: "Swift Data Processing Pipelines in Code Mono card")
}

@Image(source: "swift-data-processing-pipelines-in-mono-hero.codex", alt: "Swift Data Processing Pipelines in Code Mono hero")

Use this sheet to talk through concrete, real-world data processing pipelines from the `code/mono`
workspace. Each example shows:

- The **raw data** shape (JSON, `Data`, `UserDefaults`, Keychain).
- The **typed model** you process it into.
- The **pipeline** (decode → transform → encode, or similar).

These are great stories for Apple interviews focused on data processing, correctness, and
concurrency.

> Note: When an interviewer asks about “data processing experience,” frame your answer as a pipeline
> story: raw shape, typed model, and the decode → transform → encode steps.

> Tip: Call out where you validate input, how you surface structural risk, and where concurrency or
> backpressure shows up in the pipeline.

---

## 1. CLIA Triads Normalization (Agent/Agency/Agenda JSON)

Location:

- `code/mono/apple/spm/universal/clia/clia-agent/sources/core/clia-agent-core-cli-commands/NormalizeSchemaCommand.swift`

Purpose:

- Read JSON triad files (`*.agent.json`, `*.agency.json`, `*.agenda.json`).
- Normalize structure and `schemaVersion` to `0.4.0`.
- Detect structural-risk changes.
- Optionally verify semantic equivalence using typed models.
- Rewrite canonical JSON with sorted keys and pretty formatting.

### Core Normalization Loop

```swift
let fm = FileManager.default
var changedCount = 0
var riskDetected = false
var fileCount = 0

for dir in targets.sorted(by: { $0.path < $1.path }) {
  let files = (try? fm.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil)) ?? []
  for f in files where isTriadJSON(f) {
    fileCount += 1
    do {
      let originalData = try Data(contentsOf: f)
      guard
        let obj = try JSONSerialization.jsonObject(with: originalData) as? [String: Any]
      else { continue }

      var upgraded = obj
      let kind = docKind(for: f)
      normalize(&upgraded, kind: kind)

      // Detect structural change risk
      let structuralRisk =
        isStructuralRisk(original: obj, upgraded: upgraded, kind: kind)
        || (mergeMode != .preserve)
      if structuralRisk { riskDetected = true }

      // Force schemaVersion to 0.4.0
      upgraded["schemaVersion"] = TriadSchemaVersion.current

      let finalData = try JSONSerialization.data(
        withJSONObject: upgraded,
        options: JSON.Formatting.humanOptions
      )

      // Compare with pretty-printed original; write only if bytes differ
      if finalData != pretty(originalData) {
        changedCount += 1
        print("[normalize] \(f.path) → will update")
        if apply {
          if structuralRisk && !acknowledgeDataLoss {
            throw ValidationError("data-loss risk without acknowledgment")
          }
          if backup {
            let bak = f.deletingLastPathComponent().appendingPathComponent(
              f.lastPathComponent + ".bak"
            )
            try? fm.removeItem(at: bak)
            try originalData.write(to: bak)
          }
          if let upgradedObj = try? JSONSerialization.jsonObject(with: finalData) {
            try JSON.FileWriter.writeJSONObject(
              upgradedObj,
              to: f,
              options: JSON.Formatting.humanOptions
            )
          } else {
            try finalData.write(to: f, options: .atomic)
          }
        } else {
          printDiffPreview(original: originalData, updated: finalData, path: f.path)
        }
      }
    } catch {
      fputs("[normalize] error: \(f.path): \(error)\n", stderr)
    }
  }
}
```

### Typed Semantic Verification

The command can also confirm that the normalized JSON is *semantically* equivalent when decoded to
typed models:

```swift
private func canonicalTyped(from data: Data, kind: Kind) -> Data? {
  let dec = JSONDecoder()
  let enc = JSONEncoder()
  enc.outputFormatting = [.sortedKeys]

  switch kind {
  case .agent:
    if let v = try? dec.decode(AgentDoc.self, from: data) {
      return try? enc.encode(v)
    }
  case .agenda:
    if let v = try? dec.decode(AgendaDoc.self, from: data) {
      return try? enc.encode(v)
    }
  case .agency:
    if let v = try? dec.decode(AgencyDoc.self, from: data) {
      return try? enc.encode(v)
    }
  }
  return nil
}
```

Interview angle:

- This shows a full **data migration pipeline** with:
  - Untyped JSON → normalized JSON.
  - Optional typed decode → re-encode to check semantics.
  - Safety guards when structural risk is detected.

---

## 2. NotionTrader CLI – Shaping Notion API Payloads

Location:

- `code/mono/apple/spm/universal/domain/finance/notion-trader/Sources/NotionTraderCLI/NotionTraderCLI.swift`

Purpose:

- Provision and wire up a Notion workspace schema for trading data.
- Convert between enum-based parent descriptors and Notion’s raw JSON `Parent` structures.
- Send structured JSON requests to Notion’s HTTP API via a Codable client.

### Enum → Raw Parent via JSON Encode/Decode

When bootstrapping with an existing parent page:

```swift
let parentEnum = Notion.ParentEnum.page(
  Notion.ID<Notion.PageType>(parentPageId)
)
let parentData = try JSONEncoder().encode(parentEnum)
let parent = try JSONDecoder().decode(Notion.Parent.self, from: parentData)
```

When creating a new workspace parent:

```swift
let workspaceEnum = Notion.ParentEnum.workspace
let workspaceData = try JSONEncoder().encode(workspaceEnum)
let workspaceParent = try JSONDecoder().decode(
  Notion.Parent.self,
  from: workspaceData
)

let pageBody = Notion.PageCreateRequest.Body(
  parent: workspaceParent,
  properties: ["title": .title("NotionTrader")]
)
let pageRequest = Notion.PageCreateRequest(pageBody)
let createdPage = try await service.createPage(pageRequest)
```

### Building and Sending Database Schemas

```swift
let body = Notion.DatabaseCreateRequest.Body(
  parent: parent,
  title: [Notion.RichText(text: database.rawValue)],
  properties: baseSchema
)

try Log.notion.verbose(
  "Request: \(String(data: JSONEncoder().encode(body), encoding: .utf8) ?? "")"
)

let request: Notion.DatabaseCreateRequest = .init(body)
let created = try await service.createDatabase(request)
```

Interview angle:

- This is a nice example of mapping between **high-level enums** and **wire-level JSON** using
  encode→decode as a conversion step, and wiring that into an async network client.

---

## 3. WrkstrmKeychain – Generic Keychain + JSON Wrapper

Location:

- `code/mono/apple/spm/cross/WrkstrmKeychain/Sources/WrkstrmKeychain/Keychain.swift`

Purpose:

- Provide a light wrapper over the system Keychain that:
  - Stores arbitrary `Data`.
  - Adds a JSON layer for `Codable` models.
  - Supports biometry and iCloud Keychain flags.

### Storing and Retrieving `Codable` via JSON

```swift
public func storeCodable(
  _ model: some Codable,
  for key: String,
  requiresBiometry: Bool = false,
  synchronizable: Bool = false
) throws {
  let data = try JSONEncoder().encode(model)
  try set(
    data,
    for: key,
    requiresBiometry: requiresBiometry,
    synchronizable: synchronizable
  )
}

public func retrieveCodable<T: Codable>(
  for key: String,
  prompt: String? = nil,
  synchronizable: Bool = false
) throws -> T? {
  guard
    let data = try data(
      for: key,
      prompt: prompt,
      synchronizable: synchronizable
    )
  else {
    return nil
  }
  return try JSONDecoder().decode(T.self, from: data)
}
```

### Raw Keychain Query (Data-level)

```swift
public func set(
  _ value: Data,
  for key: String,
  requiresBiometry: Bool = false,
  synchronizable: Bool = false
) throws {
  #if canImport(Security)
  var query: [String: Any] = [
    kSecClass as String: kSecClassGenericPassword,
    kSecAttrService as String: service,
    kSecAttrAccount as String: key,
    kSecValueData as String: value,
  ]

  let accessibility: CFString =
    synchronizable
    ? kSecAttrAccessibleAfterFirstUnlock
    : kSecAttrAccessibleWhenUnlockedThisDeviceOnly

  if requiresBiometry {
    var error: Unmanaged<CFError>?
    guard
      let access = SecAccessControlCreateWithFlags(
        nil,
        accessibility,
        .userPresence,
        &error
      )
    else {
      throw KeychainError.unexpectedStatus(errSecParam)
    }
    query[kSecAttrAccessControl as String] = access
  } else {
    query[kSecAttrAccessible as String] = accessibility
  }

  if synchronizable {
    query[kSecAttrSynchronizable as String] = kCFBooleanTrue
  }

  // Best-effort delete existing item, then add new
  _ = SecItemDelete(query as CFDictionary)
  let status = SecItemAdd(query as CFDictionary, nil)
  guard status == errSecSuccess else {
    throw KeychainError.unexpectedStatus(status)
  }
  #else
  Storage.store(data: value, for: key, service: service)
  #endif
}
```

Interview angle:

- This is a low-level **raw Keychain + JSON** pipeline: very close to the metal, but still typed at
  the edges via `Codable`.

---

## 4. TokenCountServiceCache – Hashed Content → JSON Cache

Location:

- `code/mono/apple/spm/cross/WrkstrmBase/Sources/WrkstrmBase/TokenCountService.swift`

Purpose:

- Cache token counts for LLM prompts:
  - Hash prompt content with SHA-256.
  - Store a typed JSON blob (`TokenCountData`) in a dedicated `UserDefaults` suite.
  - Expire entries after a time window.

### Hashing the Content

```swift
private func hashContent(_ content: String) -> String {
  let inputData = Data(content.utf8)
  let hashedData = SHA256.hash(data: inputData)
  return hashedData.compactMap { String(format: "%02x", $0) }.joined()
}
```

### Cache Lookup + Compute + Store

```swift
public func getTokenCount(
  for content: String,
  using model: GenerativeModel
) async throws -> TokenCountData {
  let contentHash = hashContent(content)

  // Try to get from cache
  if let cachedData = defaults.data(forKey: contentHash),
    let cached = try? JSONDecoder().decode(TokenCountData.self, from: cachedData)
  {
    if Date().timeIntervalSince(cached.createdAt) < expiryInterval {
      return cached
    }
    // Cache expired
    defaults.removeObject(forKey: contentHash)
  }

  // Compute new token count
  let modelContent = [ModelContent(parts: content)]
  let response = try await model.countTokens(modelContent)

  // Cache the result
  let cacheData = TokenCountData(model: .flash, response: response)
  if let encoded = try? JSONEncoder().encode(cacheData) {
    defaults.set(encoded, forKey: contentHash)
  }

  return cacheData
}
```

### Clearing Expired Cache Entries

```swift
func clearExpiredCache() {
  let cutoffDate = Date().addingTimeInterval(-expiryInterval)

  let keys = defaults.dictionaryRepresentation().keys
  for key in keys {
    guard
      let data = defaults.data(forKey: key),
      let cached = try? JSONDecoder().decode(TokenCountData.self, from: data)
    else {
      continue
    }

    if cached.createdAt < cutoffDate {
      defaults.removeObject(forKey: key)
    }
  }
}
```

Interview angle:

- A clear, production-grade **content-based cache**:
  - Raw string → hash → JSON struct.
  - TTL enforcement and cleanup.
  - Actor-based for safe concurrent access.

---

## 5. Tau Keychain Debug – Probing Opaque Blobs

Location:

- `code/mono/apple/alphabeta/tau/mac-status-app/Debug/KeychainDebugView.swift`

Purpose:

- Inspect arbitrary Keychain entries used by Tau for secrets.
- Probe each `Data` blob and attempt to decode into known typed shapes for display.

### Probing and Decoding Opaque `Data`

```swift
if let data = try? keychain.data(for: key) {
  // Attempt to decode a Tradier envelope
  tradier = try? JSONDecoder().decode(LocalTradierSecureData.self, from: data)

  // Attempt to decode generic Notion metadata
  notion = try? JSONDecoder().decode(
    SecureData<[TypedMetadata]>.self,
    from: data
  )
}
```

This pattern repeats for different service keys to render useful debug information even when the
exact shape of the underlying blob varies.

Interview angle:

- Good example of **defensive decoding**:
  - Start from opaque `Data`.
  - Try multiple typed decoders.
  - Use what succeeds to give operators visibility into what’s stored.

---

## 6. SwiftDirectoryTools – Directory Scanning and Source Concatenation

Location:

- `code/mono/apple/spm/universal/domain/system/swift-directory-tools/Sources/SwiftDirectoryTools/SwiftDirectoryTools.swift`
- `code/mono/apple/spm/universal/domain/system/swift-directory-tools/Sources/SwiftDirectoryTools/Scanning/**`

Purpose:

- Scan project directories, applying policies and rules (for example, kebab-case filenames, no
  empty directories).
- Build a **flattened view** of many source files into:
  - A single concatenated source string or data blob.
  - An optional git patch representation for reconstruction.

This is a strong example of a **filesystem-based data processing pipeline**: directory tree →
filtered file set → combined representation (string, `Data`, or patch).

### High-level CLI: `Dflat` Tool

```swift
@main
struct DFlat: AsyncParsableCommand {
  static let configuration: CommandConfiguration = .init(
    commandName: "dflat",
    abstract: "🗂️ Harmonize your project's text-based files into a single, unified score.",
    version: "0.1.3"
  )

  @Argument(help: "The path to the directory containing the text-based files.")
  var sourceDirectories: [String]

  @Option(
    name: .shortAndLong,
    help: "The path to the output file. Include the file name and extension (.txt)."
  )
  var outputPath: String

  @Option(
    name: [.short, .customLong("prefix")],
    parsing: .upToNextOption
  )
  var prefixes: [String] = []

  @Option(
    name: [.customShort("x"), .customLong("ignore-suffix")],
    parsing: .upToNextOption
  )
  var ignoredSuffixes: [String] = []

  @Option(
    name: [.customShort("a"), .customLong("allow-suffix")],
    parsing: .upToNextOption
  )
  var allowedSuffixes: [String] = []

  func run() async throws {
    let expandedSourceDirectoriesURLs: [URL] = sourceDirectories.map {
      URL(fileURLWithPath: $0.homeExpandedString())
    }
    let outputURL = URL(fileURLWithPath: outputPath.homeExpandedString())

    let defaultIgnoredSuffixes: [String] = [".h", ".m", "README", "Package.swift", "Tests"]
    let combinedIgnoredSuffixes: [String] = defaultIgnoredSuffixes + ignoredSuffixes

    let sourceURLs = expandedSourceDirectoriesURLs.reduce(into: [URL]()) { partial, url in
      if let urls = try? SwiftDirectoryTools.relevantSourceFiles(
        in: url,
        ignoringSuffixes: combinedIgnoredSuffixes,
        allowedSuffixes: allowedSuffixes
      ) {
        partial.append(contentsOf: urls)
      }
    }

    let filteredSourceURLs: [URL] =
      prefixes.isEmpty
      ? sourceURLs
      : sourceURLs.filter { url in
        let fileName: String = url.lastPathComponent
        return prefixes.contains { prefix in fileName.hasPrefix(prefix) }
      }

    try SwiftDirectoryTools.generateSingleFile(
      from: filteredSourceURLs,
      to: outputURL,
      style: .string
    )

    print("Single file generated at: \(outputURL.path)")
  }
}
```

### Directory Scanning and Filtering: `RelevantSourceFiles`

```swift
public static func relevantSourceFiles(
  in directoryURL: URL,
  ignoringSuffixes: [String] = [],
  allowedSuffixes: [String] = [],
  verbose: Bool = false
) throws -> [URL] {
  if verbose {
    Log.verbose("directoryURL: \(directoryURL)")
  }
  var relevantFiles: [URL] = []
  var ignoredFiles: [URL]? = verbose ? [] : nil

  let fileManager: FileManager = .default
  guard
    let enumerator: FileManager.DirectoryEnumerator = fileManager.enumerator(
      at: directoryURL,
      includingPropertiesForKeys: [.isRegularFileKey, .isDirectoryKey],
      options: [.producesRelativePathURLs]
    )
  else {
    throw Self.FileError.unableToEnumerateDirectory(directoryURL)
  }

  while let item = enumerator.nextObject() as? URL {
    if verbose {
      Log.verbose("Checking: \(item.path)")
    }

    // Skip ignored prefixes or suffixes
    let hasIgnoredComponent = item.pathComponents.contains { component in
      for ignoredSequence in Self.Ignore.directoryIgnorePrefixes + ignoringSuffixes
      where component.hasPrefix(ignoredSequence) || component.hasSuffix(ignoredSequence) {
        return true
      }
      return false
    }
    if hasIgnoredComponent {
      if verbose { ignoredFiles?.append(item) }
      if let resourceValues = try? item.resourceValues(forKeys: [.isDirectoryKey]),
        resourceValues.isDirectory == true
      {
        enumerator.skipDescendants()
      }
      continue
    }

    // Only keep regular files
    guard let resourceValues = try? item.resourceValues(forKeys: [.isRegularFileKey]),
      resourceValues.isRegularFile == true
    else {
      if verbose { ignoredFiles?.append(item) }
      continue
    }

    // Suffix allow list
    if !allowedSuffixes.isEmpty {
      let fileName: String = item.lastPathComponent
      let isAllowed: Bool = allowedSuffixes.contains { suffix in
        fileName.hasSuffix(suffix)
      }
      if !isAllowed {
        if verbose { ignoredFiles?.append(item) }
        continue
      }
    }

    relevantFiles.append(item)
  }

  if verbose {
    Log.verbose("Found \(relevantFiles.count) relevant files in \(directoryURL.path)")
  }
  return relevantFiles
}
```

### Concatenating Into a Single Source Representation

```swift
static func concatenateIntoSingleData(from sourceURLs: [URL]) -> Data {
  let newline = Data("\n".utf8)

  // Pre-estimate buffer size for efficiency
  var estimatedSize = 0
  for url in sourceURLs {
    if let fileSize = try? url.resourceValues(forKeys: [.fileSizeKey]).fileSize {
      estimatedSize += fileSize
    }
    estimatedSize += url.path.count + 4  // header + newline
  }

  var fileContents: Data = .init()
  fileContents.reserveCapacity(estimatedSize)

  for sourceURL in sourceURLs {
    guard let sourceData = try? Data(contentsOf: sourceURL) else {
      Log.error(Self.FileError.unableToReadFile(sourceURL))
      continue
    }

    if let headerData = "// \(sourceURL.path)\n".data(using: .utf8) {
      fileContents.append(headerData)
    }
    fileContents.append(sourceData)
    fileContents.append(newline)
  }

  return fileContents
}

public static func generateSingleFile(
  from sourceURLs: [URL],
  to destinationURL: URL,
  style: ConcatenationStyle = .string
) throws {
  let fileContents: String
  switch style {
  case .string:
    fileContents = concatenateIntoSingleString(from: sourceURLs)
  case .data:
    let data: Data = concatenateIntoSingleData(from: sourceURLs)
    fileContents = String(decoding: data, as: UTF8.self)
  }
  try fileContents.write(to: destinationURL, atomically: false, encoding: .utf8)
}
```

Interview angle:

- This is a good example of **filesystem data processing**:
  - Structured scanning and filtering (with ignore lists and scope).
  - Efficient concatenation with size estimation and streaming.
  - Multiple target representations (string/data/git patch).

---

## 7. CommonProcess – Subprocess Streaming and Aggregated Output

Location:

- `code/mono/apple/spm/universal/common/domain/system/common-process/sources/common-process/ProcessEvent.swift`
- `code/mono/apple/spm/universal/common/domain/system/common-process/sources/common-process/ProcessOutput.swift`
- `code/mono/apple/spm/universal/common/domain/system/common-process/sources/common-process/ProcessPreviewer.swift`

Purpose:

- Provide a **streaming** view of subprocess output (stdout/stderr chunks) and a **consolidated**
  view (full captured output) from a single abstraction.
- This is the core data-processing layer that CommonShell and CLI tools build on.

### Streaming Output: `ProcessEventStream`

```swift
/// Streaming event produced by a running subprocess.
public enum ProcessEvent: Sendable, Equatable {
  /// A chunk of bytes written to standard output.
  case stdout(Data)
  /// A chunk of bytes written to standard error.
  case stderr(Data)
  /// The process has finished with a final status.
  case completed(status: ProcessExitStatus, processIdentifier: String?)
}

/// Convenience alias for the streaming sequence type.
public typealias ProcessEventStream = AsyncThrowingStream<ProcessEvent, Error>
```

- Callers that need **live output** (for example, progress bars, log tails, interactive tools) can
  consume `ProcessEventStream` directly and process each `Data` chunk as it arrives.

### Aggregated Output: `ProcessOutput`

```swift
public struct ProcessOutput: Sendable, Equatable {
  public var exitStatus: ProcessExitStatus
  public var stdout: Data
  public var stderr: Data
  public var processIdentifier: String?

  public init(
    exitStatus: ProcessExitStatus,
    stdout: Data,
    stderr: Data,
    processIdentifier: String?
  ) {
    self.exitStatus = exitStatus
    self.stdout = stdout
    self.stderr = stderr
    self.processIdentifier = processIdentifier
  }
}

extension ProcessOutput {
  /// Decodes `stdout` as UTF-8 for convenience.
  public func utf8Output() -> String { String(decoding: stdout, as: UTF8.self) }

  /// Decodes `stdout` as UTF-8 text. Use when the output is known to be textual.
  public var stdoutText: String { String(decoding: stdout, as: UTF8.self) }

  /// Decodes `stderr` as UTF-8 text. Use when the error stream is textual.
  public var stderrText: String { String(decoding: stderr, as: UTF8.self) }

  /// True when `exitStatus` is a successful zero exit code.
  public var isSuccess: Bool { exitStatus.isSuccess }
}
```

- Under the hood, CommonProcess runners accumulate the chunked `stdout`/`stderr` data into a single
  `ProcessOutput` for simple “run and capture everything” use cases.

### Bounded Previews: `ProcessPreviewer`

```swift
package struct ProcessPreviewer: Sendable {
  package init() {}

  package func previewStdout(_ text: String, options: ProcessLogOptions) -> String? {
    preview(
      text,
      maxLines: options.maxStdoutLines,
      maxBytes: options.maxStdoutBytes,
      showHeadTail: options.showHeadTail,
      headLines: options.headLines,
      tailLines: options.tailLines
    )
  }

  package func previewStderr(_ text: String, options: ProcessLogOptions) -> String? {
    preview(
      text,
      maxLines: options.maxStderrLines,
      maxBytes: options.maxStderrBytes,
      showHeadTail: options.showHeadTail,
      headLines: options.headLines,
      tailLines: options.tailLines
    )
  }

  private func preview(
    _ text: String,
    maxLines: Int?,
    maxBytes: Int?,
    showHeadTail: Bool,
    headLines: Int,
    tailLines: Int
  ) -> String? {
    // Line-based truncation with optional head+tail view
    if let maxLines, maxLines > 0 {
      let parts = text.split(separator: "\n", omittingEmptySubsequences: false)
      if parts.count > maxLines {
        guard showHeadTail else {
          return parts.prefix(maxLines).joined(separator: "\n")
            + "\n... (truncated to \(maxLines) lines)"
        }
        let headCount = min(headLines, parts.count)
        let tailCount = max(0, min(tailLines, parts.count - headCount))
        let headPart = parts.prefix(headCount).joined(separator: "\n")
        let tailPart = tailCount > 0 ? parts.suffix(tailCount).joined(separator: "\n") : ""
        let middle =
          "\n... (truncated to \(headCount)+\(tailCount) of \(parts.count) lines)\n"
        return headPart + middle + tailPart
      }
      return text
    }

    // Byte-based truncation
    if let maxBytes, maxBytes > 0 {
      var byteCount = 0
      var output = ""
      for character in text {
        let characterLength = String(character).utf8.count
        if byteCount + characterLength > maxBytes { break }
        output.append(character)
        byteCount += characterLength
      }
      if output.count < text.count { return output }
      return text
    }

    return nil
  }
}
```

Interview angle:

- CommonProcess shows a **dual-view pipeline**:
  - Chunked `Data` events for streaming (`ProcessEventStream`).
  - Aggregated `ProcessOutput` for simple use.
  - A preview layer (`ProcessPreviewer`) that turns large raw output into safe, bounded summaries
    for logs and UIs.

### Runner Ordering Fix: Queues + Sync Group

To keep stdout/stderr events and the final aggregate output in order, the Foundation-backed runner:

- Uses dedicated dispatch queues for stdout and stderr.
- Uses a `DispatchGroup` to ensure all queued chunks are appended before we snapshot buffers.

Key snippet:

```swift
// FoundationRunner.swift (simplified)
private static let executionQueue = DispatchQueue(
  label: "common-process.foundation-runner",
  qos: .userInitiated
)
private static let stdoutQueue = DispatchQueue(
  label: "common-process.foundation-runner.stdout",
  qos: .userInitiated,
  autoreleaseFrequency: .workItem
)
private static let stderrQueue = DispatchQueue(
  label: "common-process.foundation-runner.stderr",
  qos: .userInitiated,
  autoreleaseFrequency: .workItem
)

private func launchProcess(
  context: RunnerContext,
  holder: ProcessHolder,
  continuation: CheckedContinuation<RunnerResult, Error>
) throws {
  let stdoutBox = ThreadSafeDataBox()
  let stderrBox = ThreadSafeDataBox()

  let stdoutPipe = Pipe()
  let stderrPipe = Pipe()
  let syncGroup = DispatchGroup()

  let process = Process()
  process.executableURL = context.executableURL
  process.arguments = context.arguments
  process.environment = context.environment
  holder.process = process

  // macOS: handle chunks as they arrive
  stdoutPipe.fileHandleForReading.readabilityHandler = { handle in
    let chunk = handle.availableData
    guard !chunk.isEmpty else {
      handle.readabilityHandler = nil
      return
    }
    syncGroup.enter()
    FoundationLifecycleDelegate.stdoutQueue.async {
      stdoutBox.append(chunk)
      holder.emit?(.stdout(chunk))
      syncGroup.leave()
    }
  }

  stderrPipe.fileHandleForReading.readabilityHandler = { handle in
    let chunk = handle.availableData
    guard !chunk.isEmpty else {
      handle.readabilityHandler = nil
      return
    }
    syncGroup.enter()
    FoundationLifecycleDelegate.stderrQueue.async {
      stderrBox.append(chunk)
      holder.emit?(.stderr(chunk))
      syncGroup.leave()
    }
  }

  process.standardOutput = stdoutPipe
  process.standardError = stderrPipe

  process.terminationHandler = { proc in
    FoundationLifecycleDelegate.executionQueue.async {
      // Stop handlers, read any tail, enqueue them, then wait for all chunks.
      stdoutPipe.fileHandleForReading.readabilityHandler = nil
      stderrPipe.fileHandleForReading.readabilityHandler = nil

      let stdoutTail = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
      if !stdoutTail.isEmpty {
        syncGroup.enter()
        FoundationLifecycleDelegate.stdoutQueue.async {
          stdoutBox.append(stdoutTail)
          holder.emit?(.stdout(stdoutTail))
          syncGroup.leave()
        }
      }

      let stderrTail = stderrPipe.fileHandleForReading.readDataToEndOfFile()
      if !stderrTail.isEmpty {
        syncGroup.enter()
        FoundationLifecycleDelegate.stderrQueue.async {
          stderrBox.append(stderrTail)
          holder.emit?(.stderr(stderrTail))
          syncGroup.leave()
        }
      }

      let waitResult = syncGroup.wait(timeout: .now() + .seconds(10))
      if waitResult == .timedOut {
        // log sync timeout
      }

      let finalStdout = stdoutBox.snapshot()
      let finalStderr = stderrBox.snapshot()
      // build RunnerResult / ProcessOutput from finalStdout/finalStderr...
    }
  }

  try process.run()
}
```

Implementation note:

- An earlier bug could surface out-of-order chunks when bridging from the underlying process
  streams to `ProcessEvent`/`ProcessOutput`. The combination of:
  - dedicated stdout/stderr queues, and
  - a `DispatchGroup` barrier at termination
  ensures all previously enqueued chunks are flushed and appended before the final snapshot, so
  ordering is preserved.

---

## How to Use These in Interviews

- Pick 1–2 stories that match the prompt:
  - **Config/migration** → CLIA triads normalization.
  - **External APIs** → NotionTrader + Notion JSON shaping.
  - **Security/credentials** → WrkstrmKeychain and WrkstrmSecrets.
  - **Caching/perf** → TokenCountServiceCache.
- Walk through:
  - The raw data source (Keychain, JSON, UserDefaults, network).
  - The typed model (`Codable`/domain types).
  - The processing pipeline and invariants.
  - How you validate and test the flow.
