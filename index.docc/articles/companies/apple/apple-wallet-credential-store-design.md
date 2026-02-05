# Apple Wallet Credential Store Design

@PageImage(purpose: card, source: "companies-apple-apple-wallet-credential-store-design-card.codex", alt: "Placeholder card")
@Image(source: "companies-apple-apple-wallet-credential-store-design-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-apple-apple-wallet-credential-store-design-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Review Apple Wallet Credential Store Design")
  @PageImage(purpose: icon, source: "apple-wallet-credential-store-design-icon.codex", alt: "Apple Wallet Credential Store Design icon")
  @PageImage(purpose: card, source: "apple-wallet-credential-store-design-card.codex", alt: "Apple Wallet Credential Store Design card")
}

@Image(source: "apple-wallet-credential-store-design-hero.codex", alt: "Apple Wallet Credential Store Design hero")

## Overview

- Goal: capture the design of a cross-platform credential store (WrkstrmSecrets) that can back
  Apple Wallet–style data processing and concurrency flows.
- Scope: how secrets are modeled, stored, and migrated across backends such as Apple Keychain and
  in-memory stores, and how this composes with async token and identity flows.

Use this article as an interview-ready story when talking about Wallet, PassKit, and secure
storage of tokens and credentials.

## Problem Statement

- You need to manage multiple secret types:
  - API keys and tokens (for example, AI providers).
  - Broker credentials and envelopes (for example, Schwab, Tradier).
  - Integration secrets for databases and backends (for example, Notion).
- Requirements:
  - Strong typing and clear ownership for each secret type.
  - Cross-platform behavior:
    - Apple platforms: use Keychain with access groups and synchronizable items.
    - Non-Apple: fall back to in-memory or alternate backends.
  - Safe composition with Swift concurrency and actor-based flows.
  - A clean data processing pipeline: encode → persist → read → validate → feed into higher-level
    flows like OAuth and Verify with Wallet.

Interview framing: you are designing the “credential store” that Wallet-style components depend on
for secure tokens and identities.

## Core APIs for Secret Storage

### Capability and Configuration Checks

- **Capabilities and environment:**
  - On Apple platforms, you rely on Keychain entitlements and access groups to safely store
    secrets.
  - On other platforms, you use in-memory or alternate backends for local tools and tests.
- **Configuration as source of truth:**
  - `TauKit.SecretsConfig.resolve()`:
    - Reads `KEYCHAIN_SERVICE`, `KEYCHAIN_ACCESS_GROUP`, and `KEYCHAIN_SYNCHRONIZABLE` from the
      environment.
    - Produces a `Configuration` value with:
      - `service`: Keychain service name.
      - `accessGroup`: access group for sharing secrets across apps.
      - `synchronizable`: whether items should sync over iCloud.
      - `accessPolicy`: baseline access policy, such as `.defaultSyncableWhenUnlocked`.
  - `AppleSecretsStack.make(configuration:)`:
    - Creates a `SecretsStoring` that uses `AppleKeychainBackend` behind the scenes.

Design pattern (mirroring PassKit): **capability + configuration object** first, then hand that
configuration to higher-level APIs.

### Core Building Blocks

### `SecretCoder` and Typed IDs

- `SecretCoder` protocol:
  - `init(decode data: Data) throws`
  - `func encode() throws -> Data`
  - `static var id: ServiceID<Self> { get }`
- Extension for `Codable` types:
  - Default `encode()` uses `JSONEncoder` with sorted keys for deterministic bytes.
  - Default `init(decode:)` uses `JSONDecoder` to rebuild the value.
- Each secret type declares a static `id`:
  - `OpenAISecret.id = ServiceID<OpenAISecret>(path: "ai/openai")`
  - `GeminiSecret.id = ServiceID<GeminiSecret>(path: "ai/gemini")`
  - `NotionSecret.id = ServiceID<NotionSecret>(path: "database/notion")`
  - `SchwabCredentialsSecret.id = ServiceID<SchwabCredentialsSecret>(path: "brokers/schwab/credentials")`
- Paths form a logical namespace (`ai/*`, `database/*`, `brokers/*`) and become the “account” in
  Keychain.

Takeaway: secrets are strongly typed, with stable, namespaced identifiers that drive storage keys.

### `SecretsStoring` and `SecretsBackend`

- Two protocol layers:
  - `SecretsStoring` (high-level):
    - `save<C: SecretCoder>(_ secret: C) throws`
    - `read<C: SecretCoder>(_ id: ServiceID<C>) throws -> C?`
    - `delete<C: SecretCoder>(_ id: ServiceID<C>) throws`
    - `listAccounts() throws -> [String]`
  - `SecretsBackend` (low-level backend):
    - Knows how to `save`, `read`, and `delete` using a `SecretQuery<C>`.
    - Implements `listAccounts(service:accessGroup:)` for discovery and preflight checks.
- `ServiceID<C>` + `SecretQuery<C>`:
  - `ServiceID` holds a `path` string (for example, `"brokers/schwab/credentials"`).
  - `SecretQuery` expands that into Keychain attributes:
    - `service` (Keychain service name).
    - `account` (the path).
    - `accessGroup` and `synchronizable`.

Takeaway: you separate the logical identifier (`ServiceID`) from the physical storage attributes
(`SecretQuery`).

### Backends and Aggregation

- `InMemoryBackend`:
  - Simple dictionary keyed by `service|account`.
  - Useful for tests and non-Apple platforms; marked `@unchecked Sendable` and used under
    controlled access (for example, within an actor).
- `AppleKeychainBackend`:
  - Uses `Security` framework and generic password class.
  - Writes JSON-encoded data to Keychain with:
    - `kSecAttrService` = configuration service string.
    - `kSecAttrAccount` = `ServiceID` path.
    - Optional `kSecAttrAccessGroup` and `kSecAttrSynchronizable`.
    - `kSecAttrAccessibleWhenUnlocked` as a baseline; richer `AccessPolicy` support can be layered
      on later.
  - Reads by matching the same attributes and decoding with `SecretCoder`.
- `AggregateSecretsStore`:
  - Implements `SecretsStoring` and fans out to multiple `SecretsBackend`s.
  - `Options` support:
    - `primaryIndex`: which backend to write to by default.
    - `migrateOnRead`: if data is found in a non-primary backend, re-save it into the primary on
      successful read.
  - `listAccounts()`:
    - Unions accounts across all backends for the configured `service` and `accessGroup`.

Takeaway: backends handle “where” data lives; the aggregate store handles migrations and
multi-backend behavior.

## API Surface: How to Use the Store

### Creating a Store

- Resolve configuration:

  ```swift
  let configuration = SecretsConfig.resolve()
  ```

- Create a store:

  ```swift
  let store: any SecretsStoring = AppleSecretsStack.make(configuration: configuration)
  ```

### Defining a Secret Type

- Example: Schwab client credentials:

  ```swift
  public struct SchwabCredentialsSecret: Codable, SecretCoder, Sendable {
    public static let id = ServiceID<SchwabCredentialsSecret>(
      path: "brokers/schwab/credentials"
    )

    public var clientID: String
    public var clientSecret: String
    public var updatedAt: Date
  }
  ```

### Saving and Reading Secrets

- Save:

  ```swift
  let secret = SchwabCredentialsSecret(
    clientID: "...",
    clientSecret: "...",
    updatedAt: .now
  )
  try store.save(secret)
  ```

- Read:

  ```swift
  let credentials = try store.read(SchwabCredentialsSecret.id)
  ```

- Delete:

  ```swift
  try store.delete(SchwabCredentialsSecret.id)
  ```

This mirrors Apple’s API style:

- A **typed configuration** (`Configuration`) and environment resolver (`SecretsConfig.resolve()`).
- A **factory** (`AppleSecretsStack.make`) to create a store.
- Strongly typed value objects and a small, predictable method surface on the main protocol.

## Data Processing Pipeline

### Encoding and Persistence

- In-memory:
  - You hold a strongly typed value like `SchwabCredentialsSecret` or `NotionSecret`.
- Encode:
  - Call `encode()` from `SecretCoder` (JSON with sorted keys).
- Persist:
  - `AggregateSecretsStore.save(secret)`:
    - Builds a `SecretQuery` from `Configuration` and `C.id`.
    - Calls `save` on the primary backend (Keychain, in-memory, or both).

### Reading, Migration, and Validation

- Read path:
  - `AggregateSecretsStore.read(id)`:
    - Builds a `SecretQuery` from the provided `ServiceID`.
    - Iterates backends until one returns a decoded value.
    - If `migrateOnRead` is enabled and the value came from a non-primary backend:
      - Saves it back into the primary backend for future reads.
- Validation via preflight:
  - `SecretsPreflight.run(on:)`:
    - Calls `listAccounts()` to see which IDs are present.
    - Reads specific secrets (for example, `NotionSecret`, `SchwabCredentialsSecret`) and validates
      shape:
      - Empty tokens.
      - Missing IDs.
      - Empty broker envelopes.
    - Emits `PreflightFinding` values at levels `.info`, `.warn`, `.error`.

Takeaway: the store is not just persistence; it drives health checks and migrations, which is
important for Wallet-like systems that must fail fast when credentials are broken.

## Concurrency and Async Flows

### `Sendable` Everywhere

- Secret types (`OpenAISecret`, `NotionSecret`, `SchwabCredentialsSecret`, `TradierSecureEnvelope`)
  conform to `Codable, SecretCoder, Sendable`.
- Store and backend protocols are `Sendable` or `@unchecked Sendable` where necessary.
- This supports:
  - Passing secrets and stores across Swift concurrency boundaries.
  - Using the credential store from actors and async tasks safely.

Interview callout: highlighting `Sendable` shows you are thinking about data races and isolation in
Wallet-style flows.

### Integration with Token Actors

- `AccessTokenStorage` and `PublicRequestAuthenticator` illustrate how the store composes with
  async actors:
  - A long-lived secret (for example, refresh token or API key) is stored in the credential store.
  - A background component loads it into `AccessTokenStorage`.
  - `PublicRequestAuthenticator` (an actor) exchanges it for short-lived access tokens using
    HTTP-based flows and caches them until expiry.
  - The actor:
    - Exposes `accessToken() async throws -> String`.
    - Refreshes tokens when expired.
    - Clears tokens after a configurable duration using `Task.sleep`.
- Pattern for Wallet:
  - Store long-lived credentials (for example, issuer keys, Wallet API tokens, identity secrets) in
    the credential store.
  - Use actors to:
    - Exchange them for short-lived access tokens.
    - Drive verification or issuance flows (for example, Verify with Wallet, issuer provisioning).

Takeaway: the credential store handles durable secret storage; actors handle ephemeral tokens and
concurrent access.

## Cross-platform Behavior for Wallet-like Systems

- Apple platforms:
  - Use `AppleSecretsStack.make(configuration:)` to build a `SecretsStoring` backed by
    `AppleKeychainBackend`.
  - Configure:
    - `service` name (for example, `"TauIntegrations"`).
    - `accessGroup` for multi-app sharing.
    - `synchronizable` for iCloud syncing.
  - Combine with entitlements (Wallet, pass type IDs, identity entitlements) to gate flows.
- Non-Apple platforms:
  - Use `InMemoryBackend` or additional backends as needed.
  - Keep the same `SecretsStoring` surface so business logic and tests remain unchanged.
- Migration story:
  - Start with in-memory only (during development or in tooling).
  - Introduce Keychain backend as primary with migration-on-read enabled.
  - Gradually retire legacy stores once data has migrated.

Takeaway: the same credential store API works across environments; only the backend wiring changes.

## How to Present This to Apple Wallet Teams

### When Asked About Secure Storage and Data Processing

- Start with:
  - The problem: many secret types, cross-platform constraints, Wallet-style security bar.
  - The architecture: `SecretCoder`, `ServiceID`, `SecretsStoring`, multiple backends.
  - The pipeline: encode → store → read → validate → feed into token/identity flows.
- Emphasize:
  - Strong typing (`SecretCoder`, `Sendable`).
  - Typed IDs and namespacing (`ServiceID` paths).
  - Keychain attribute mapping (service, account, access group, synchronizable).
  - Preflight checks to detect invalid or missing secrets early.

### When Asked About Concurrency

- Call out:
  - The use of `Sendable` and value types for secrets.
  - Actor-based components (like `PublicRequestAuthenticator`) that sit on top of the store.
  - How you would:
    - Wrap `SecretsStoring` in an actor in a production Wallet app.
    - Coordinate background refresh and UI flows with that actor.

### When Asked About Tradeoffs and Extensions

- Discuss:
  - Pros:
    - Strongly typed secrets.
    - Multi-backend support and migration.
    - Cross-platform behavior with a consistent API.
  - Cons / next steps:
    - Enforce concurrency more strictly (actors around the store).
    - Expand `AccessPolicy` to drive more nuanced Keychain settings
      (biometric-protected, device-only items).
    - Add audit logging or metrics around secret access for sensitive Wallet flows.

End with how you would adapt this design to Wallet-specific needs (for example, identity presentment
pipelines, issuer provisioning, secure element key handling) while preserving the same core
principles.
