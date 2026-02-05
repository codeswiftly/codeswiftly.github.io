# PassKit Common API Practices


@Metadata {
  @TitleHeading("Review PassKit Common API Practices")
}


## Overview

- Goal: capture cross-cutting API patterns in PassKit (Apple Pay + Wallet) so you can reason about
  new APIs and design interview-ready solutions.
- Sources: sosumi.ai PassKit index and the focused raw pages you have for Apple Pay, Wallet, and
  Verify with Wallet.

Use this as a quick mental checklist whenever a PassKit-style design question comes up.

## Capability Checks Before UI

- **Static probes:**
  - `PKPaymentAuthorizationController.canMakePayments(…)`, `supportsDisbursements(…)`,
    `PKPaymentRequest.availableNetworks()` are used to gate flows before presenting Apple Pay or
    payment UI.
  - Wallet identity APIs use `PKIdentityAuthorizationController.checkCanRequestDocument(...)` to
    decide whether to show a Verify with Wallet button.
- **Design pattern:**
  - Always **check capabilities first**, then show system-branded UI only when supported; provide
    fallbacks otherwise.

## Configuration Objects As Sources of Truth

- **Request types:**
  - Apple Pay: `PKPaymentRequest`, `PKDisbursementRequest`, `PKRecurringPaymentRequest`,
    `PKAutomaticReloadPaymentRequest`, `PKDeferredPaymentRequest`, `PKPaymentTokenContext`.
  - Wallet identity: `PKIdentityRequest`.
  - Wallet passes: `PKAddSecureElementPassConfiguration`, `PKAddShareablePassConfiguration`,
    `PKAddCarKeyPassConfiguration`, and friends.
- **Responsibilities:**
  - Encapsulate merchant identifiers, capabilities, country/currency, payment summary items,
    shipping methods, contacts, coupons, and identity descriptors.
  - Serve as the single configuration handed to controllers or SwiftUI buttons to initiate flows.
- **Design pattern:**
  - Prefer a **single, strongly typed request object** over scattered parameters; this makes
    evolution and testing easier.

## Controller + Delegate (Or Closure) Patterns

- **Controllers:**
  - `PKPaymentAuthorizationController`, `PKAddSecureElementPassViewController`,
    `PKAddPassesViewController`, `PKShareSecureElementPassViewController`, identity controllers.
- **Delegates and handlers:**
  - Delegates such as `PKPaymentAuthorizationControllerDelegate` expose events:
    - Sheet presentation and dismissal.
    - Payment method selection, coupon changes, shipping contact/method changes.
    - Final authorization status and post-authorization events.
  - Many delegate methods take handler/closure parameters that expect update objects
    (`PKPaymentRequestUpdate`, `PKPaymentRequestShippingContactUpdate`, etc.).
- **SwiftUI buttons:**
  - Types like `PayWithApplePayButton`, `AddPassToWalletButton`, and `VerifyIdentityWithWalletButton`
    wrap these flows in SwiftUI, using closures `onRequest`, `onCompletion`, and optional
    `fallback` instead of explicit delegates.
- **Design pattern:**
  - **Controller + delegate** for UIKit; **button + closures** for SwiftUI, both backed by the same
    underlying configuration and update types.

## Typed Value Objects for Money, Items, and Schedules

- **Money and items:**
  - `PKPaymentSummaryItem` and variants (`PKRecurringPaymentSummaryItem`,
    `PKAutomaticReloadPaymentSummaryItem`, `PKDeferredPaymentSummaryItem`) use `NSDecimalNumber` for
    amounts and explicit `type` enums (final vs pending).
- **Schedules and ranges:**
  - Date and interval types use `Date`, `DateComponents`, and wrappers like `PKDateComponentsRange`
    for delivery windows.
- **Stored-value and transit:**
  - `PKStoredValuePassProperties` + `PKStoredValuePassBalance` and `PKTransitPassProperties` /
    `PKSuicaPassProperties` model balances and transit-specific state.
- **Design pattern:**
  - Avoid “naked” primitives; wrap money, intervals, and balances in well-named types with clear
    semantics.

## Strong Enums, Option Sets, and Error Domains

- **Networks and capabilities:**
  - `PKPaymentNetwork` and `PKMerchantCapability` enums/option sets with `rawValue` initializers and
    a long list of static cases for networks and features.
- **Status and modes:**
  - `PKPaymentAuthorizationStatus`, Apple Pay Later availability enums, contact editing modes,
    payment method types, identity error codes, and vehicle connection states.
- **Error types and domains:**
  - Scoped error types (`PKPassKitError`, `PKAddPaymentPassError`, `PKIdentityError`,
    `PKShareSecureElementPassError`, etc.) plus error domains
    (`PKPassKitErrorDomain`, `PKIdentityErrorDomain`, …).
- **Design pattern:**
  - Use **typed enums and option sets** instead of ad-hoc strings; centralize error codes per
    subsystem with dedicated domains.

## Update Objects and Validation Flows

- **Payment sheet updates:**
  - Classes like `PKPaymentRequestUpdate`, `PKPaymentRequestPaymentMethodUpdate`,
    `PKPaymentRequestShippingContactUpdate`, and `PKPaymentRequestCouponCodeUpdate` bundle:
    - Updated payment summary items.
    - Updated shipping methods.
    - Arrays of user-facing errors.
- **Error factories:**
  - `PKPaymentRequest` exposes helper methods to construct standard errors for invalid billing
    addresses, unserviceable shipping, or coupon code problems.
- **Design pattern:**
  - Validation results are **structured objects** (items + errors), not loose tuples; this gives
    the system enough information to update UI consistently.

## Entitlements, Capabilities, and Security Boundaries

- **Entitlements drive access:**
  - Wallet passes: pass type IDs entitlement.
  - Apple Pay: merchant IDs entitlement.
  - Verify with Wallet: in-app identity presentment entitlement.
- **Capabilities:**
  - Wallet and Apple Pay capabilities must be enabled per-target.
  - Identity and issuer APIs are further gated by platform versions and program enrollment.
- **Design pattern:**
  - Security-sensitive APIs always combine **entitlements + configuration objects + system-owned
    UI**, rather than exposing raw primitives.

### Certificate and Signing Hygiene (Passes)

- **Pass Type ID identity, not just a .cer:**
  - Treat the Pass Type ID certificate as an **identity** (certificate + private key) in your
    keychain or HSM, not as a loose `.cer` file checked into a repo.
  - Ensure the Pass Type ID CSR is generated on the machine (or service) that will sign passes so
    the private key is actually available there.
- **Avoid signing with generic dev certificates:**
  - When calling tools like `security cms -S`, always target the Pass Type ID identity by name;
    avoid accidentally using the default Apple Development identity, which produces passes Wallet
    will reject.
- **Backend as signing boundary:**
  - In production, move pass signing to a backend service that:
    - Owns the Pass Type ID keys and WWDR intermediates.
    - Validates requests, rate-limits abuse, and logs issued passes for audit.
    - Returns ready-to-use `.pkpass` blobs for apps to present via PassKit.
  - This keeps keys out of app bundles and developer laptops while aligning with PassKit’s
    entitlement and trust model.

## System-owned Buttons and Views

- **Why they exist:**
  - To ensure consistent branding, localization, and accessibility for flows like Apple Pay, Add to
    Wallet, and Verify with Wallet.
- **Examples:**
  - `PKAddPassButton`, `AddPassToWalletButton`, `PayWithApplePayButton`,
    `VerifyIdentityWithWalletButton`, Apple Pay Later merchandising views (now deprecated).
- **Design pattern:**
  - Give clients **style and label enums**, not pixel-perfect control; keep the UX recognizable and
    trustworthy.

## Putting it Together in Interviews

When asked to design a new PassKit-style API, lean on these patterns:

- Start with a **capability check** (static probe) gated by entitlements.
- Define a **configuration object** that captures everything needed for the flow.
- Expose either:
  - A **controller + delegate** API (UIKit), or
  - A **button + closure** API (SwiftUI).
- Model money, time, and identity with **typed value objects**.
- Use **enums/option sets** for networks, capabilities, statuses, and errors, organized by error
  domain.
- Return **structured update objects** with both data and validation errors.
- Keep **system-owned UI** responsible for consent and critical user flows (payments, identity,
  Wallet additions), while your app focuses on configuration and handling results.
