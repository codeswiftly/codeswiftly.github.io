@PageImage(purpose: card, source: "companies-apple-apple-wallet-passkit-wallet-apis-card.codex", alt: "Placeholder card")
@Image(source: "companies-apple-apple-wallet-passkit-wallet-apis-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-apple-apple-wallet-passkit-wallet-apis-icon.codex", alt: "Placeholder icon")
# Wallet Apis in PassKit

@Metadata {
  @TitleHeading("Review Wallet Apis in PassKit")
  @PageImage(purpose: icon, source: "apple-wallet-passkit-wallet-apis-icon.codex", alt: "Wallet Apis in PassKit icon")
  @PageImage(purpose: card, source: "apple-wallet-passkit-wallet-apis-card.codex", alt: "Wallet Apis in PassKit card")
}

@Image(source: "apple-wallet-passkit-wallet-apis-hero.codex", alt: "Wallet Apis in PassKit hero")

## Overview

- Goal: understand the Wallet-specific APIs in PassKit so you can design and reason about flows for
  passes, secure element credentials, identity, and shareable passes.
- Emphasis: capability gating (entitlements), configuration + UI patterns, and error surfaces
  across Wallet APIs.

Use this alongside <doc:apple-wallet-api-design> for higher-level API design prompts.

## Capabilities and Entitlements

- **Wallet capability:**
  - Your app must enable the Wallet capability to access passes via PassKit.
- **Key entitlements:**
  - **Pass type IDs entitlement** (`com.apple.developer.pass-type-identifiers`): which pass types
    the app can access.
  - **Merchant IDs entitlement** (`com.apple.developer.in-app-payments`): which merchant IDs the app
    uses for Apple Pay.
  - **In-app identity presentment** (`com.apple.developer.in-app-identity-presentment`): allows
    age/identity verification using IDs in Wallet.
- **Interview framing:**
  - Call out that Wallet flows are security-sensitive and always gated by entitlements and team
    identifiers; APIs reflect that with explicit configurations and limits on what an app can see.

## Core Wallet Types

- **Object hierarchy:**
  - `PKObject`: opaque base type for pass objects.
  - `PKPass`: represents a single Wallet pass (boarding pass, ticket, store card, etc.).
  - `PKSecureElementPass`: pass backed by a secure element credential (payment cards, keys).
  - `PKPaymentPass`: payment card for in-app payments.
- **Pass library:**
  - `PKPassLibrary`: interface to the user’s pass library (querying, adding, removing, updating).
- **Value helpers and buttons:**
  - `PKLabeledValue`: key/value metadata for cards or passes (for example, card details).
  - `PKAddPassButton` (UIKit) and `AddPassToWalletButton` (SwiftUI) for “Add to Wallet” flows.

Design pattern: a small set of core types represent passes and their storage; apps use high-level
buttons and view controllers to initiate add/share flows.

## General-purpose Pass Flows

- **Adding passes:**
  - `PKAddPassesViewController`: presents a pass and prompts the user to add it to Wallet.
  - `PKAddSecureElementPassViewController`: specialized view controller for secure element
    (payment/key) passes, configured by `PKAddSecureElementPassConfiguration`.
- **Sharing secure element passes:**
  - `PKShareSecureElementPassViewController`: UI for sharing secure element passes.
  - `PKShareSecureElementPassViewControllerDelegate`: delegate for completion and error handling.
  - `PKShareSecureElementPassResult`: reports sharing outcomes.
  - `AsyncShareablePassConfiguration`, `PKShareablePassMetadata` (+ `Preview`), and
    `PKAddShareablePassConfiguration`: configuration and metadata types for shareable passes.

API pattern: **configuration object + dedicated view controller or button + delegate/closure for
results**.

## Identity Passes and Verify with Wallet

- **Identity flows:**
  - “Verify with Wallet” lets apps verify age or identity using IDs stored in Wallet.
  - Client side: request attributes (for example, age-over-21) via dedicated identity APIs, present
    a system UI, and receive an encrypted response.
  - Server side: decrypt and verify presentment requests (`verifying-wallet-identity-requests`).
- **Key types and buttons (from docs):**
  - Identity descriptors for photo IDs and attributes (for example, `PKIdentityPhotoIDDescriptor`).
  - `VerifyIdentityWithWalletButton` (and style types) provide a system-branded button for these
    flows.
- **Design takeaways:**
  - Strong separation between **requesting attributes in-app** and **verifying on the server**.
  - Minimal disclosure: APIs are framed around specific attributes (for example, “over 21”) instead
    of raw document dumps.

In interviews, tie this back to privacy-preserving API design and selective disclosure.

See also: <doc:apple-wallet-requesting-identity-data-design> for a deeper breakdown of
`PKIdentityRequest` flows.

## Stored-value and Transit Passes

- **Transit and stored-value properties:**
  - `PKTransitPassProperties`: transit-specific properties (for example, ride eligibility,
    remaining rides).
  - `PKSuicaPassProperties`: Suica-specific transit details.
  - `PKStoredValuePassProperties`: generic stored-value properties for passes with balances
    (transit, loyalty, gift cards).
  - `PKStoredValuePassBalance`: represents balances in points or money.
- **Design implications:**
  - Domain-specific property objects wrap raw balances and rules (expired, low balance, etc.).
  - APIs expose **read-only, derived properties** rather than letting apps mutate balances directly;
    updates typically come from issuers.

You can use these as examples when asked to design stored-value or loyalty APIs in Wallet.

## Shareable Passes

- **Sharing model:**
  - `PKAddShareablePassConfiguration`: describes how a pass can be shared (for example, guest
    invites, family members).
  - `PKShareablePassMetadata`: controls the sharing sheet (title, description, preview).
  - `PKAddShareablePassConfigurationPrimaryAction`: indicates what action the system performs when
    adding the shared pass.
- **Patterns to note:**
  - The system owns the sharing UX; apps configure metadata and intent.
  - APIs encode **what** kind of sharing is allowed, not raw details about recipients or custom
    networking.

Use this to talk about designing safe sharing APIs (bounded actions, system-owned UI, clear audit).

## Digital Car Keys and Issuer Flows

- **Digital car keys:**
  - `PKAddCarKeyPassConfiguration`: specialized configuration for adding car keys.
  - `PKVehicleConnectionSession` + delegate types: manage connection to the vehicle during
    provisioning and use, with a clear connection state enum.
- **Issuer cards and Wallet extensions:**
  - “Issuer provisioning” APIs let banks or partners issue cards directly into Wallet.
  - `PKIssuerProvisioningExtensionHandler`: base class for Wallet extension handlers that add
    payment cards.
  - `PKIssuerProvisioningExtensionAuthorizationProviding`: protocol for authorizing users in UI
    extensions.

Design themes: **extension-based architecture**, well-scoped delegates, and configuration objects
that bridge Wallet, issuers, and vehicles.

## Error Types and Domains

- **Error enums and domains:**
  - `PKPassKitError` / `PKPassKitError.Code`: general PassKit error container.
  - `PKAddSecureElementPassError` (+ `.Code`), `PKAddPaymentPassError`: flow-specific error enums.
  - `PKIdentityError` (+ `.Code`): identity-related failures.
  - `PKShareSecureElementPassError` (+ `.Code`): errors when sharing secure element passes.
  - Error domains: `PKPassKitErrorDomain`, `PKIdentityErrorDomain`,
    `PKAddSecureElementPassErrorDomain`, `PKShareSecureElementPassErrorDomain`.
- **Interview-ready framing:**
  - Errors are **typed and namespaced** by domain and code; APIs do not throw arbitrary strings.
  - This matches a good design practice: stable error contracts that client code can switch over
    safely.

When designing new Wallet APIs, mirror this: define clear error enums and domains per subsystem.

## Patterns to Carry Into Your Own Designs

- Capability and entitlement checks gate access to sensitive passes and identity flows.
- Configuration-first APIs: construct a configuration object, then hand it to a system-owned UI
  (view controller or button) to run the flow.
- Strongly typed models for passes, balances, identity attributes, and errors instead of loose
  dictionaries.
- System-branded buttons and sheets (Add to Wallet, Verify with Wallet) for consistency and trust.
- Clear split between on-device flows (UX) and server verification/issuance.

Bring these up when asked to:

- Design a new Wallet pass type or sharing model.
- Extend Wallet identity or stored-value flows.
- Integrate issuers or vehicles while keeping the user experience and security model coherent.

## Wallet-relevant PassKit Surface (Inventory)

Use this section as a quick map from high-level Wallet concepts to the concrete PassKit symbols and
raw docs in `apple-passkit-raw/`.

- **Core Wallet pass models**
  - Types: `PKPass`, `PKSecureElementPass`, `PKPaymentPass`, `PKPassLibrary`, `PKLabeledValue`,
    plus Add to Wallet UI like `PKAddPassButton` and `AddPassToWalletButton`.
  - Symbol docs live under paths such as:
    - `apple-passkit-raw/documentation-passkit-pkpass-*.md`
    - `apple-passkit-raw/documentation-passkit-pksecureelementpass-*.md`
    - `apple-passkit-raw/documentation-passkit-pkpaymentpass-*.md`
  - These pages link out to Wallet overviews like “Get started with Apple Wallet”.

- **Add to Wallet and shareable passes**
  - Types: `PKAddPassesViewController`, `PKAddSecureElementPassViewController`,
    `PKAddSecureElementPassConfiguration`, `PKShareSecureElementPassViewController` (and its
    delegate/result/error types), `PKAddShareablePassConfiguration`, `PKShareablePassMetadata`,
    and `AddPassToWalletButtonStyle`.
  - Raw docs include:
    - `apple-passkit-raw/documentation-passkit-pkaddpassesviewcontroller-raw.md`
    - `apple-passkit-raw/documentation-passkit-pkaddsecureelementpassconfiguration-raw.md`
    - `apple-passkit-raw/documentation-passkit-pksharesecureelementpassviewcontroller-raw.md`
    - `apple-passkit-raw/documentation-passkit-addpasstowalletbuttonstyle-*-raw.md`

- **Verify with Wallet and identity passes**
  - Types: `PKIdentityAuthorizationController`, `PKIdentityRequest`, `PKIdentityDocument`,
    descriptor types like `PKIdentityDriversLicenseDescriptor`,
    `PKIdentityNationalIDCardDescriptor`, `PKIdentityPhotoIDDescriptor`, `PKIdentityAnyOfDescriptor`
    and UI such as `PKIdentityButton`, `VerifyIdentityWithWalletButton`,
    `VerifyIdentityWithWalletButtonLabel`, `VerifyIdentityWithWalletButtonStyle`, plus
    `PKIdentityError`.
  - Key guides:
    - `apple-passkit-raw/requesting-identity-data-from-a-wallet-pass-raw.md`
    - The “verifying identity requests” companion article in the same directory.
  - These link to the Verify with Wallet API overview and ISO 18013-5 references; see also
    `<doc:apple-wallet-iso18013-data-processing>` for design notes.

- **Transit, stored-value, and car keys**
  - Types: `PKTransitPassProperties`, `PKSuicaPassProperties`, `PKStoredValuePassProperties`,
    `PKStoredValuePassBalance`, `PKAddCarKeyPassConfiguration`, `PKVehicleConnectionSession` and
    its delegates.
  - Example raw docs:
    - `apple-passkit-raw/documentation-passkit-pktransitpassproperties-isinstation-raw.md`
    - other `pktransitpassproperties`, `pksuicapassproperties`, and `pkstoredvalue*` pages.
  - These describe how Wallet surfaces transit state, balances, and car-key state in the UI.

- **Issuer provisioning and Wallet Extensions**
  - Types: `PKIssuerProvisioningExtensionHandler`,
    `PKIssuerProvisioningExtensionAuthorizationProviding` and related extension APIs.
  - Guide:
    - `apple-passkit-raw/documentation-passkit-implementing-wallet-extensions-raw.md`
      (“Implementing Wallet Extensions”), which explains adding cards to Apple Pay directly within
      Apple Wallet and links to further Wallet extension docs and sample code.

- **Error domains and shared support types**
  - Types: `PKPassKitError`, `PKAddSecureElementPassError`, `PKAddPaymentPassError`,
    `PKIdentityError`, `PKShareSecureElementPassError`, with domains such as
    `PKPassKitErrorDomain`, `PKIdentityErrorDomain`, `PKAddSecureElementPassErrorDomain`, and
    `PKShareSecureElementPassErrorDomain`.
  - These are used across all Wallet-facing flows above and form the stable error surface.

## Linked Documentation and Future Automation

- **Common outbound links from Wallet-related PassKit docs:**
  - Wallet platform docs such as “Get started with Apple Wallet” and “Add to Apple Wallet
    Guidelines”.
  - Verify with Wallet API overview and “Verifying Wallet identity requests” (server-side).
  - Human Interface Guidelines sections for Wallet passes and Verify with Wallet buttons.
  - Sample-code articles like “Implementing Wallet Extensions”.

- **Tracking and automation notes:**
  - The raw PassKit mirrors live under
    `code/mono/docc/private/host/local/swift-interview-guide.docc/apple-passkit-raw/` and are indexed by
    `passkit-index.json` (see `<doc:apple-passkit-traversal>` for CLI details).
  - If you want an always-up-to-date machine-readable list of “Wallet-related PassKit pages plus the
    `/documentation` and `/tutorials` links they reference”, you can extend the `carrie-docs
    passkit` CLI with a subcommand (for example, `wallet-apis`) that:
    - Reads `passkit-index.json` and the corresponding raw `.md` files.
    - Selects entries whose content mentions Wallet or matches a curated Wallet symbol set.
    - Extracts outbound links and writes a JSON summary for downstream agents.
