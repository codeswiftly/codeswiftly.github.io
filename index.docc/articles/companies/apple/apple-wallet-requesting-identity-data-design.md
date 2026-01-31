@PageImage(purpose: card, source: "companies-apple-apple-wallet-requesting-identity-data-design-card.codex", alt: "Placeholder card")
@Image(source: "companies-apple-apple-wallet-requesting-identity-data-design-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-apple-apple-wallet-requesting-identity-data-design-icon.codex", alt: "Placeholder icon")
# API Design: Requesting Identity Data from a Wallet Pass

@Metadata {
  @TitleHeading("Review API Design: Requesting Identity Data from a Wallet Pass")
  @PageImage(purpose: icon, source: "apple-wallet-requesting-identity-data-design-icon.codex", alt: "API Design Requesting Identity Data from a Wallet Pass icon")
  @PageImage(purpose: card, source: "apple-wallet-requesting-identity-data-design-card.codex", alt: "API Design Requesting Identity Data from a Wallet Pass card")
}

@Image(source: "apple-wallet-requesting-identity-data-design-hero.codex", alt: "API Design Requesting Identity Data from a Wallet Pass hero")

## Mental Model and Roles

- **What this API does:**
  - Lets an app verify age or identity by requesting specific attributes from an ID stored in Wallet
    (mobile driver’s license, national ID, or Apple-issued digital ID).
  - The system mediates user consent, talks to the issuing authority, and returns an encrypted
    payload that follows ISO 18013-5.
- **Key actors:**
  - **Client app:** builds descriptors and requests, shows system sheets, forwards encrypted data to
    your backend.
  - **Wallet + system UI:** enforces consent and entitlement checks; talks to issuers.
  - **Backend:** verifies the payload (issuer + device signatures, nonce, attributes) and makes
    policy decisions.

When designing or discussing this API, keep that split in mind: client code requests and displays,
the backend verifies and authorizes.

## Entitlements, Info.plist, and Prerequisites

- **Entitlement:**
  - Requires the Verify with Wallet entitlement (documented as `com.apple.developer.in-app-identity-presentment`)
    and macOS 13+ for development.
  - Without this entitlement, identity requests aren’t allowed.
- **Merchant identifier:**
  - Every request needs a merchant identifier configured in the developer portal.
  - Identical conceptually to Apple Pay merchant IDs; identifiers don’t expire and can be reused.
- **Usage description:**
  - `NSIdentityUsageDescription` must be present in your app’s Info.plist with a clear explanation
    of why you’re requesting identity data.
  - Missing this key causes all requests to fail.

Interview takeaway: always call out entitlements + Info.plist keys up front when talking about this
API.

## Designing Identity Document Descriptors

Descriptors describe **what** identity data you want and how you intend to store it.

- **Descriptor types:**
  - `PKIdentityDriversLicenseDescriptor`: mobile/state driver’s license attributes.
  - `PKIdentityNationalIDCardDescriptor`: national ID card attributes (includes ISO + JP elements).
  - `PKIdentityPhotoIDDescriptor`: digital IDs (Apple-issued).
  - `PKIdentityAnyOfDescriptor`: “any of these documents” — for flows that accept multiple ID
    types.
- **Elements and storage intent:**
  - For each element (for example, `givenName`, `familyName`, `portrait`, `age(atLeast:)`), you
    specify an intent:
    - `.mayStore(days: N)`: you plan to store the element for N days.
    - `.mayStore`: you may store it without a time limit (subject to policy).
    - `.willNotStore`: you will not persist this element beyond the current flow.
  - The system surfaces this intent to the user in the system sheet.
- **Age-specific rules:**
  - You can request `age(atLeast:)` for any age between 1 and 125, but only if the issuer provides
    that element.
  - If `age_over_XX` is absent, the framework falls back to requesting the `age` element.
  - You cannot mix `age(atLeast:)` and raw `age` in the same request.

Design guidance:

- Keep the descriptor minimal: request only the attributes you actually need.
- Be explicit about storage intent to match privacy and compliance expectations.

## Preflight: Can You Request This Document?

- **Controller:**
  - Create a `PKIdentityAuthorizationController` to manage requests.
- **Availability check:**
  - Call `checkCanRequestDocument(_:completion:)` with your descriptor.
  - If `canRequest` is `false`, hide/disable your “Verify with Wallet” button or fall back to other
    verification methods.

This enforces a clean pattern: **preflight capability check → show system-branded button → run
flow.**

## Building a Request

- **Core request type:**
  - `PKIdentityRequest` holds:
    - `descriptor`: what you want and how you intend to store it.
    - `merchantIdentifier`: your merchant ID from the developer portal.
    - `nonce`: a server-generated, per-session value that prevents replay.
- **Nonce design:**
  - Generated on your backend, bound to the user session, used exactly once.
  - Required to decrypt and validate the response on the server.

API design pattern: **configuration object** (`PKIdentityRequest`) encapsulates everything the
system needs; the app passes it to a controller instead of hand-coding lower-level protocols.

See also: <doc:apple-wallet-nonce-and-session-design> for a deeper dive into nonce and session
design.

## Running the Request and Handling Results

- **Requesting the document:**
  - Use `await controller.requestDocument(request)` from Swift concurrency.
  - The system presents a sheet where the person:
    - Sees what attributes you’re requesting and the storage intent.
    - Chooses whether to share or cancel.
- **Errors and cancellation:**
  - If the person cancels, you receive `PKIdentityError.Code.cancelled`.
  - If another request is already in progress, you get `PKIdentityError.Code.requestAlreadyInProgress`.
  - Other `PKIdentityError` cases cover configuration and entitlement problems.
- **Successful response:**
  - You receive a `PKIdentityDocument` containing:
    - `encryptedData`: opaque, issuer-signed, device-signed payload (ISO 18013-5 structure).
    - Metadata about the document.
  - The client **cannot and should not** inspect `encryptedData` directly; send it to your backend
    over a secure channel.

In interviews, emphasize that the client app never trusts identity data until the backend verifies
it.

## Server-side Verification (High Level)

- **Verification steps (from the companion “Verifying Wallet identity requests” doc):**
  - Decrypt the payload using keys associated with your merchant identifier.
  - Validate:
    - Issuer signature (the authority that issued the ID).
    - Device signature (ties the response to a device and session).
    - Nonce and timestamp (guards against replay).
    - Requested attributes and their namespaces (ISO, AAMVA, JP).
  - Decide whether to accept, reject, or require additional checks based on your policy.
- **API design considerations:**
  - Treat the server as the **source of truth** for identity decisions.
  - Expose a small, typed response back to clients (for example, `ageVerified: Bool`, `country`),
    not the raw decoded ISO document.

This separation of concerns is a strong design talking point: client for UX, server for trust.

See also: <doc:apple-wallet-iso18013-data-processing> for a deeper dive into backend processing of
ISO 18013-5 payloads.

## Mapping Descriptors to Namespaces

- **Descriptor → namespace mappings:**
  - `PKIdentityDriversLicenseDescriptor` → ISO + AAMVA elements.
  - `PKIdentityPhotoIDDescriptor` → ISO elements.
  - `PKIdentityNationalIDCardDescriptor` → ISO + JP elements.
- **Design implications:**
  - Your backend must understand which namespaces and elements to expect for each descriptor.
  - Keep server-side schema and validation logic versioned and testable.

You can mention these mappings to show familiarity with standards (ISO 18013-5, AAMVA, JP).

## Concurrency and Request Limits

- Only one identity request can be in progress at a time:
  - The framework enforces this and returns `requestAlreadyInProgress` if you violate it.
  - At the app level, model this as:
    - A single in-flight request per user session.
    - UI gates (disable buttons) while a request is pending.

This is a simple but important invariant to call out in system design discussions.

## Testing Strategy

- **Simulator vs device:**
  - Simulator and developer profiles return **mock mDLs**:
    - Simulator: mock document without real issuer or device signatures.
    - Developer test profile: real device signature, but still not a real issuer signature.
  - Mock IDs do not appear in the Wallet UI; they exist only for testing the flow.
- **What to test:**
  - Happy path: descriptor → checkCanRequest → requestDocument → backend verification.
  - Cancellations and repeated taps (ensure you handle `cancelled` and
    `requestAlreadyInProgress` cleanly).
  - Descriptor variations (age-only, age-at-least, photo + name, etc.).

Mentioning this test story shows you understand how to validate identity flows even without live
production IDs.

## Design Principles to Surface in Interviews

- **Least privilege:** request only the attributes you need; avoid overbroad descriptors.
- **Explicit storage intent:** use `.mayStore` / `.mayStore(days:)` / `.willNotStore` thoughtfully
  and explain why.
- **System-owned consent UI:** rely on the system sheet and Wallet UI for transparency and trust,
  not custom screens.
- **Backend as authority:** never treat on-device responses as final; always verify on the server.
- **Typed contracts:** favor descriptor types, enums, and error codes over stringly-typed fields.

Use this API as a concrete case study when asked about secure, privacy-preserving API design in
Wallet or identity systems.
