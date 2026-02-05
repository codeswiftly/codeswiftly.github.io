# Apple Wallet Credential Store vs System APIs



Use this as a quick reference when talking about how our credential store (WrkstrmSecrets) compares to Apple’s Wallet / PassKit APIs in interviews.

## High-level Role

- **Apple (PassKit, Wallet, Verify with Wallet)**
  - System frameworks.
  - Own entitlements, system UI, consent flows, storage (Secure Element, Keychain).
  - Expose high-level types and callbacks; storage is an implementation detail.
- **Ours (WrkstrmSecrets)**
  - Pure Swift library.
  - Models and stores secrets across backends (Keychain, in-memory, future backends).
  - Callers own UI, policy, and higher-level flows (token exchange, identity, Wallet logic).

## API Shape and Responsibilities

- **Configuration**
  - Apple:
    - Many specialized configuration types, each tied to a flow:
      - `PKPaymentRequest`, `PKDisbursementRequest`, recurring/deferred request types.
      - `PKIdentityRequest` + identity descriptors.
      - `PKAddSecureElementPassConfiguration`, `PKAddShareablePassConfiguration`, `PKAddCarKeyPassConfiguration`, etc.
    - Configuration objects are the single source of truth for each flow.
  - Ours:
    - Single `Configuration` type for storage:
      - `service`, `accessGroup`, `synchronizable`, `accessPolicy`.
    - `SecretsConfig.resolve()` builds that configuration from environment variables.
    - `AppleSecretsStack.make(configuration:)` turns it into a `SecretsStoring` backed by Keychain.

- **Core surface**
  - Apple:
    - Asynchronous, flow-specific APIs:
      - Controllers (`PKPaymentAuthorizationController`, identity controllers, add/share controllers).
      - SwiftUI buttons (`PayWithApplePayButton`, `AddPassToWalletButton`, `VerifyIdentityWithWalletButton`).
      - Delegates and closures for events.
  - Ours:
    - One small, synchronous protocol:
      - `SecretsStoring` with:
        - `save<C: SecretCoder>(_ secret: C) throws`
        - `read<C: SecretCoder>(_ id: ServiceID<C>) throws -> C?`
        - `delete<C: SecretCoder>(_ id: ServiceID<C>) throws`
        - `listAccounts() throws -> [String]`
    - Typed models (`SecretCoder` + `ServiceID`) and backends are composed on top.

## Security, UX, and Data Flow

- **Entitlements and system-owned UI**
  - Apple:
    - Requires specific entitlements:
      - Wallet / Pass type IDs.
      - Apple Pay merchant IDs.
      - In-app identity presentment for Verify with Wallet.
    - Uses system-owned UI and buttons for:
      - Apple Pay sheets.
      - Add to Wallet.
      - Verify with Wallet.
    - The system, not your app, is responsible for consent and branding.
  - Ours:
    - No entitlements or built-in UI at the library level.
    - We rely on how your app is provisioned for Keychain entitlements, but WrkstrmSecrets itself is headless.
    - Apps and tools must build their own UX and consent layers around the store.

- **Data handling**
  - Apple:
    - For identity:
      - The app receives an encrypted ISO 18013-5 payload (`PKIdentityDocument.encryptedData`).
      - The app forwards it to the backend, which verifies signatures, nonce, and attributes.
      - Client code never inspects raw identity fields; the server is the authority.
    - For passes and payments:
      - Apps work with pass and payment abstractions.
      - Underlying keys and tokens stay inside Wallet / Secure Element / Keychain.
  - Ours:
    - Explicitly stores long-lived secrets:
      - API keys, broker credentials, integration tokens, envelopes.
    - Returns these secrets as strongly typed values to calling code.
    - Higher-level components (for example, token actors) then:
      - Exchange long-lived secrets for short-lived access tokens.
      - Drive Verify-with-Wallet-style backends or other services.

## Data Modeling and Storage Abstraction

- **Domain specificity**
  - Apple:
    - Models domain objects directly:
      - Passes (`PKPass`, `PKSecureElementPass`).
      - Payment requests, summary items, disbursements.
      - Identity descriptors and attributes (age, name, address, portrait).
      - Stored-value and transit properties.
  - Ours:
    - Models generic secrets:
      - `SecretCoder` + arbitrary `Codable & Sendable` structs like:
        - `OpenAISecret`, `GeminiSecret`, `NotionSecret`, `SchwabCredentialsSecret`, `TradierSecureEnvelope`.
      - `ServiceID` paths namespace secrets (for example, `"ai/openai"`, `"database/notion"`, `"brokers/schwab/credentials"`).
    - The library does not know about passes or ISO structures; that lives in higher layers.

- **Storage abstraction**
  - Apple:
    - Storage internals (Secure Element, Keychain) are hidden.
    - Public APIs talk in terms of passes, tokens, identity documents, and attributes.
  - Ours:
    - Storage is explicit and composable:
      - `SecretsBackend` protocol.
      - `InMemoryBackend` for tests and non-Apple platforms.
      - `AppleKeychainBackend` for Keychain-backed storage.
      - `AggregateSecretsStore` to fan out writes and perform migration-on-read.
    - Callers can see and choose how and where secrets are persisted.

## Concurrency Model

- **Flow orchestration vs data access**
  - Apple:
    - Concurrency mostly coordinates user flows:
      - Controllers and buttons present system UI on the main thread.
      - Async methods (`await controller.requestDocument(...)`) and delegate callbacks drive the lifecycle.
  - Ours:
    - Concurrency is about safe data access and token lifecycles:
      - Secrets and configuration types are `Sendable` value types.
      - Backends and stores are `Sendable` or `@unchecked Sendable`.
      - Actor-based components (for example, `PublicRequestAuthenticator`) sit on top:
        - Expose `accessToken() async throws -> String`.
        - Cache short-lived tokens and clear them with `Task.sleep`.

- **Async vs sync APIs**
  - Apple:
    - Many operations are async by design:
      - Identity requests.
      - Payment authorizations.
      - Pass provisioning and sharing flows.
  - Ours:
    - Storage operations are synchronous and throwing:
      - `save`, `read`, `delete`, `listAccounts` are blocking calls.
    - Async behavior (network calls, token refresh, backoff) lives above the store in actors and clients.

## Error and Policy Surfaces

- **Error modeling**
  - Apple:
    - Rich, domain-specific error enums and domains for each subsystem:
      - `PKPassKitError`, `PKAddSecureElementPassError`, `PKIdentityError`, `PKShareSecureElementPassError`.
      - Error domains like `PKPassKitErrorDomain`, `PKIdentityErrorDomain`, etc.
  - Ours:
    - More generic error surface at the storage layer:
      - `SecretsBackend` methods `throw` on failures (including `NSError` from `Security` for Keychain).
      - Typed policy errors live in higher layers (for example, token exchange, broker clients), not in WrkstrmSecrets itself.

- **Policy expression**
  - Apple:
    - Policy is encoded into configuration objects:
      - Identity storage intent (`.willNotStore`, `.mayStore`, `.mayStore(days:)`).
      - Descriptor types and requested attributes.
      - Merchant identifiers and entitlements.
  - Ours:
    - Storage policy is coarse in the library:
      - `Configuration.accessPolicy` (for example, default syncable when unlocked).
      - Environment flags controlling service name, access group, synchronizable.
    - Fine-grained data retention and privacy policies are implemented by callers using:
      - Preflight checks (for example, `SecretsPreflight.run(on:)`).
      - Their own deletion and rotation strategies.

## How to Tell This Story in Interviews

- Lead with the **different roles**:
  - Apple’s APIs are system-level, entitlement- and UX-driven.
  - WrkstrmSecrets is a library-level, cross-platform secret store.
- Call out where we **mirror Apple’s patterns**:
  - Strongly typed configuration objects (`Configuration`, `SecretCoder`, `ServiceID`).
  - Small, focused protocol surface (`SecretsStoring`) similar to how PassKit centralizes on request/controller types.
- Then highlight the **key differences**:
  - We expose storage and migration primitives; Apple exposes higher-level flows and hides storage.
  - We use actors and `Sendable` for concurrency; Apple uses controllers, delegates, and system-owned buttons.
  - We hand typed secrets to your code; Apple often hands opaque payloads that must be verified on the server.

Framing it this way shows you understand both how to design clean Swift APIs and how they plug into system frameworks like Wallet and PassKit.
