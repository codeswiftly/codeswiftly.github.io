# Apple Wallet API Design


@Metadata {
  @TitleHeading("Review Apple Wallet API Design")
}


## Overview

- Goal: practice talking through Apple Wallet style APIs that serve multiple platforms (iOS, macOS,
  watchOS) and partners (internal frameworks, external issuers, backend services).
- Emphasis: clear boundaries, safety for money/identity flows, and APIs that are easy to evolve
  without breaking existing consumers.

Use this as a scaffold for system design and API design rounds focused on Wallet, passes, and
credentials.

## PassKit Framework Overview

- **Two main capabilities:**
  - Add Apple Pay to your iOS and watchOS apps for purchasing real‑world goods and services or
    donating to nonprofits without leaving the app.
  - Create, distribute, and manage passes in the user’s Wallet app on iPhone and Apple Watch.
- **Apple Pay (in-app):**
  - Built on PassKit APIs; handles tokenized, secure payments so your app never sees full card
    numbers.
  - Best suited for physical goods, services, and donations that exist outside the app; digital
    content delivered inside the app should use In‑App Purchase instead.
  - For web flows, Apple Pay on the Web uses related but distinct integration points.
- **Wallet and passes:**
  - PassKit lets you generate and sign passes that users can add to Wallet from apps, email, or the
    web.
  - Passes can surface on the Lock Screen when time/location relevance rules match, and can be
    updated via push notifications.
  - The same framework underpins pass management (add, update, remove) and Apple Pay card
    management in Wallet.

Use this mental model in interviews: PassKit is the client-side bridge between your app and Wallet
for both Apple Pay and pass lifecycle management.

## PassKit API Patterns to Remember

- **Capability checks before UI:**
  - Static probes like `canMakePayments(...)`, `supportsDisbursements(...)`, and
    `availableNetworks()` to gate flows before showing Apple Pay or Wallet affordances.
- **Configuration objects for requests:**
  - Central request types (`PKPaymentRequest`, recurring/automatic/deferred variants,
    `PKDisbursementRequest`, `PKPaymentTokenContext`) that you populate with merchant, region,
    summary items, shipping methods, and contacts.
- **Controller + delegate async flows:**
  - `PKPaymentAuthorizationController` drives the sheet; delegates and status enums like
    `PKPaymentAuthorizationStatus` report progress, validation errors, and completion.
- **Typed value objects for money and schedules:**
  - `PKPaymentSummaryItem` and its recurring/automatic/deferred variants use `NSDecimalNumber` for
    amounts and `Date`/`DateComponents` for timing and intervals.
- **Strong enums and option sets:**
  - Networks, merchant capabilities, item types, method types, editing modes, and availability flags
    are modeled as enums/option sets with `rawValue` initializers for forward compatibility.
- **Standardized error factories:**
  - Helper methods on `PKPaymentRequest` create localized, typed errors for invalid billing,
    shipping, or coupon codes, keeping validation consistent across clients.
- **Rich contact and shipping models:**
  - `PKContact`, `PKShippingMethod`, and `PKDateComponentsRange` capture names, addresses, methods,
    and delivery windows as structured data instead of loose dictionaries.
- **Buttons instead of manual flows:**
  - UIKit and SwiftUI components (`PKAddPassButton`, `AddPassToWalletButton`,
    `PayWithApplePayButton`) wrap common UX with style/label enums and closure-based handlers
    (`onRequest`, `onCompletion`, optional fallbacks) instead of hand-rolled UI.

When sketching new Wallet APIs, mirror these patterns: capability probes, a strongly typed request
object, a single controller or button entry point, and structured callbacks or updates for user
interaction and validation.

## Key Wallet API Design Patterns (Summary + Diagrams)

This section summarizes the most important patterns and shows how data and control flow between the
**app**, **Wallet / PassKit**, and your **backend**.

### Pattern 1: Capability Probe + System Button

Before showing any Wallet UI, the app probes capabilities and entitlements and only then presents a
system-branded button.

```text
App                         System / Wallet
 |                               |
 |  canAddPasses? canMakePayments? supportsIdentity?  (capability probes)
 |------------------------------->|
 |            boolean flags       |
 |<-------------------------------|
 |                               |
 |  show Add to Wallet / Verify with Wallet button
 |------------------------------>|
```

Key ideas:

- Capability checks happen *before* any controller or sheet is created.
- The API surface exposes simple booleans or typed capability sets, not ad-hoc string flags.
- Buttons like `PKAddPassButton` and `VerifyIdentityWithWalletButton` encapsulate styling and
  localization so your code only wires up intent and callbacks.

### Pattern 2: Configuration Object + Controller Or Button

Flows that add or share Wallet items follow a consistent structure:

- You build a **configuration object** that captures everything about the request.
- You hand it to a **system-owned view controller or button**.
- That controller manages user interaction and calls you back with a typed result.

```text
App                           Wallet / PassKit                Backend (issuer)
 |                                   |                              |
 |  build PKAddSecureElement         |                              |
 |  PassConfiguration /              |                              |
 |  PKAddShareablePassConfiguration |                              |
 |---------------------------------->|                              |
 |                                   |  present system UI           |
 |                                   |----------------------------> |
 |                                   |   (user taps Add / Share)    |
 |                                   |<---------------------------- |
 |                                   |                              |
 |   delegate / completion(result)   |                              |
 |<----------------------------------|                              |
```

Design takeaways:

- Configurations are **immutable intents**: they describe *what* you want (card, key, share token),
  not how the issuer implements it.
- The view controller or button is the only entry point; you do not manually assemble Wallet UI.
- Results are expressed as enums/typed objects instead of anonymous dictionaries.

### Pattern 3: Verify with Wallet Identity Request

Verify with Wallet splits responsibilities cleanly between the app, Wallet, and your server:

```text
App                       Wallet / Identity UI           Issuer / Your Server
 |                                |                               |
 |  descriptor + PKIdentityRequest|                               |
 |-------------------------------->|                               |
 |                                |  show consent sheet           |
 |                                |-----------------------------> |
 |                                |   (user approves attributes)  |
 |                                |<----------------------------- |
 |     PKIdentityDocument         |                               |
 |<-------------------------------|                               |
 |                                |                               |
 |  send encryptedData + nonce    |------------------------------>|
 |                                |      decrypt + verify +       |
 |                                |   apply storage policy        |
 |                                |<------------------------------|
 |    business decision / token   |                               |
```

Patterns to highlight:

- The app requests **attributes**, not raw documents (`age(atLeast:)` vs full DOB).
- The encrypted payload is **opaque** to the app; verification is a server concern.
- Storage intent (`mayStore`, `willNotStore`) is explicit in the request descriptor.

### Pattern 4: Stored-value and Issuer-authoritative Balances

Stored-value and transit passes use typed property wrappers and issuer-owned state:

```text
Issuer Backend             Wallet / PassKit                 App
      |                           |                         |
      |  issue / update pass      |                         |
      |-------------------------->|                         |
      |   signed pass + balance   |                         |
      |<--------------------------|                         |
      |                           |                         |
      |                           |  PKStoredValuePass...   |
      |                           |  exposes read-only      |
      |                           |  balance / flags        |
      |                           |-----------------------> |
      |                           |   display balance       |
      |                           |<----------------------- |
```

Design principles:

- The **issuer** is the single source of truth for balances and ride eligibility.
- The app consumes **read-only, derived properties** (`PKStoredValuePassBalance`, transit property
  objects) instead of mutating balances directly.
- Updates flow via signed pass updates, not imperative “set balance” calls.

You can reuse these diagrams as talking points when sketching new APIs: decide which parts belong
to configuration objects, which belong to system-owned UI, and which must be issuer- or
server-authoritative.

## Overview of Wallet Passes

- **What passes are:**
  - Digital representations of cards and credentials such as payment cards, boarding passes, event
    tickets, coupons, store cards, gift cards, and generic membership or claim tickets.
  - Managed in the Wallet app on iPhone and Apple Watch; synced across a user’s devices via iCloud.
- **Presentation and relevance:**
  - Time and location aware: passes can be configured to surface on the Lock Screen at the right
    moment (for example, arriving at an airport or walking into a store).
  - Users can tap into a pass from a notification when details change (gate changes, balance
    updates, schedule shifts).
- **Pass styles:**
  - Styles include boarding pass, coupon, event ticket, store card, and generic pass.
  - The style determines layout, fields, relevance windows, and location radius defaults; choosing
    the right type ensures appropriate UX and behavior.
- **Distribution and updates:**
  - Passes can be distributed from native apps, websites, or email.
  - Users can add passes even if they do not have the related app installed; an associated app can
    be suggested from the pass.
  - Updates flow via push notifications or manual refresh on the pass, propagating new details and
    balances.
- **Redemption and acceptance:**
  - Passes can be redeemed via NFC readers (contactless) or by scanning a barcode (QR, Aztec,
    PDF417).
  - Wallet optimizes on-device presentation for scanning (backlight, orientation), and can show
    fallback text such as membership numbers when scanning is unavailable.
- **Security and signing:**
  - Passes are signed with Apple-issued certificates tied to a developer account; only apps with
    the correct entitlements can access their passes.
  - Expired certificates stop new signing and updates but do not immediately break installed
    passes; revoked certificates invalidate passes.

Keep these behaviors in mind when designing APIs: types, lifecycles, and events should map cleanly
onto how passes are issued, displayed, redeemed, and updated in Wallet today.

## Problem Spaces to Anchor on

- **Transit:**
  - Express Mode tap-to-ride, card provisioning, balance/top-up, and trip history.
  - Offline and low-connectivity behavior at gates.
- **Access:**
  - Home, hotel, and car key access flows.
  - Credential lifecycle: issuance, revocation, device migration.
- **Identity:**
  - Driver’s licenses and IDs in Wallet.
  - Age verification and sharing minimal attributes with apps.
- **Provisioning:**
  - “Add to Wallet” flows from apps, web, and email.
  - Moving credentials between devices and restoring on new hardware.

Pick one of these domains for a design prompt and stay concrete about actors and flows.

## API Design Principles to Highlight

- **Clear responsibility boundaries:**
  - Separate concerns: UI frameworks vs data/model frameworks vs backend client libraries.
  - Keep Wallet’s public APIs focused on “what” (intent) rather than “how” (issuer-specific logic).
- **Safety and correctness first:**
  - Strong typing for credential IDs, token types, and capabilities.
  - Avoid “stringly typed” APIs for security-critical fields.
  - Prefer explicit enums and option sets over loose dictionaries.
- **Evolution and versioning:**
  - Design for additive changes: new fields, capabilities, and credential types.
  - Use options/feature flags instead of breaking existing callers.
- **Privacy by design:**
  - Minimize data shared with apps/servers; expose only what is necessary for the flow.
  - Make consent and revocation explicit in the API shape.
- **Performance and power:**
  - Batch operations where possible (for example, fetching multiple passes at once).
  - Offer asynchronous APIs that cooperate with system scheduling and background execution.

Have 2–3 specific examples ready where you applied these principles in past work.

## Example: Pass Provisioning API Sketch

Prompt variant:

> Design a client-side API that lets apps add a credential (card, pass, or key) into Wallet, and
> track its status.

Possible model:

- High-level types:
  - `WalletCredentialKind` (transit card, access key, identity document, payment credential).
  - `WalletCredentialState` (pending, active, suspended, revoked, expired).
  - `WalletProvisioningRequest` with:
    - Issuer identifier.
    - Credential kind and capabilities.
    - Optional metadata (localized display name, icon references).
- Core operations:
  - `provisionCredential(request:completion:)` or async variant.
  - `credentialState(for:completion:)` to poll or subscribe to state changes.
  - Optional observer or delegate hooks for UI: progress, additional verification, errors.

Talking points:

- Strong typing: avoid raw `String` IDs for kinds and states; use enums.
- Security: do not expose full credential details to apps; only share a stable handle and minimal
  status.
- Extensibility: make `WalletCredentialKind` extensible or versioned so new credential types can be
  added later.

## Example: Access Control and Keys

Prompt variant:

> Design APIs to manage “keys” in Wallet (home, hotel, car) that work offline and across devices.

Outline:

- Model:
  - `WalletKey` with:
    - `id`, `issuer`, `supportedDoors/zones`, `validFrom`, `validUntil`.
    - Capabilities: unlock only, unlock + start, temporary guest access.
  - `WalletKeyAccessEvent` for audit and debugging, carefully permissioned.
- APIs:
  - `listKeys(filter:)` with pagination and lightweight summaries.
  - `requestUnlock(using:options:) async` returning a result with timing info, error codes, and
    fallback hints.
  - `shareKey(_:with:permissions:)` for guest/temporary sharing, if allowed by issuer.

Discussion points:

- Offline behavior and caching: which data can be cached on-device, which actions must be online.
- Failure modes: expired keys, revoked issuers, device time skew, hardware issues.
- Privacy: who can see access history; default to least detail and explicit opt-in.

## Example: Identity and Selective Disclosure

Prompt variant:

> Design APIs to let an app verify that a user is over 21 using an ID in Wallet without learning the
> user’s full address.

Ideas:

- Types:
  - `WalletIdentityDocument` with:
    - Document type (driver’s license, state ID).
    - Issuer region and validity period.
  - `WalletIdentityAttribute` enum (ageOver18, ageOver21, region, etc.).
- APIs:
  - `requestIdentityAttributes(_:for:completion:)` where the app requests a set of attributes and
    Wallet mediates user consent and disclosure.
  - Result returns only approved attributes, not the full document.

Highlight:

- Principle of least privilege and minimizing long-lived identifiers.
- UX: user-facing confirmation sheet that explains what is being shared and why.

## Networking and Background Processing

Key points to mention when APIs cross the network:

- **Reliability:**
  - Idempotent operations with client-generated identifiers for provisioning and updates.
  - Retries with backoff for transient failures; clear mapping from network errors to user-facing
    messages.
- **Background behavior:**
  - Use system background tasks for refresh and reconciliation.
  - Clearly separate “user-initiated” flows (foreground UI) from background maintenance.
- **Security:**
  - TLS everywhere; certificate pinning when appropriate.
  - Careful handling of tokens/keys; segregate secret material from high-level Wallet APIs when
    sketching designs.

## Interview Structure for API Design

When an interviewer asks an Apple Wallet API design question:

- Start with **clarifying questions**:
  - Who are the primary consumers (apps, frameworks, backend services)?
  - What are hard constraints (offline operation, latency, privacy, regulatory rules)?
- Propose a **simple, concrete API surface**:
  - A small set of core types and operations.
  - One or two flows (for example, provisioning + status, or selective disclosure).
- Iterate in **layers**:
  - V1: correctness and safety.
  - V2: performance, power, and ergonomics.
  - V3: evolution and backward compatibility.
- Narrate tradeoffs:
  - Why you chose async vs callback, how you handle errors, and how you support new credential types
    over time.

Aim to leave the interviewer with a clear picture of:

- What the API looks like at the call site.
- How it behaves under failure, scale, and evolution.
- How it protects users’ money, identity, and privacy.
