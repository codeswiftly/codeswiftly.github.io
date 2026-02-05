# Creating Passes for Apple Wallet (PassKit)


@Metadata {
  @TitleHeading("Review Creating Passes for Apple Wallet (PassKit)")
}


## Overview

Use this article to walk an interviewer through how you would design and build an Apple Wallet pass
with PassKit, from choosing a style to signing and distribution. Focus on:

- Picking the right pass style for the use case.
- Structuring the pass JSON.
- Signing and packaging `.pkpass` files.
- Presenting Add to Wallet flows in an app.

Pair this with:

- <doc:apple-passkit-common-api-practices>
- <doc:apple-wallet-passkit-wallet-apis>

for API-level discussion.

## 1. Choose a Pass Style and Use Case

PassKit gives you several pass styles:

- **Boarding pass** – flights, trains, buses; time- and location-sensitive.
- **Coupon** – discounts, offers, single-use barcodes.
- **Event ticket** – concerts, movies, sports, conferences.
- **Store card** – gift cards, loyalty cards, stored value.
- **Generic** – membership cards, claim tickets, other custom cases.

Interview framing:

- Start by describing the product scenario (for example, event ticket or membership card).
- Explain why a specific style fits (relevance window, locations, fields shown on the lock screen).

## 2. Configure Pass Type IDs and Certificates

Before you can create real passes, you need:

- An **Apple Developer account** with the Wallet capability.
- A **Pass Type ID** (for example, `pass.com.example.gymkhana.membership`).
- A **Wallet pass certificate** associated with that Pass Type ID.

High-level steps (no need to recite the portal UI step-by-step):

- Define a Pass Type ID in Certificates, Identifiers & Profiles.
- Request and download a **Pass Type ID certificate** and install it in your keychain.
- Plan how you will store and use the certificate for signing (local tool vs server).

In interviews, call out that:

- The certificate is used to sign passes so Wallet can trust the issuer.
- The Pass Type ID scopes which passes your app can access via entitlements.

## 3. Design the Pass Payload (JSON)

Every pass has a `pass.json` file that declares:

- **Required top-level fields:**
  - `description` – short human-readable description.
  - `formatVersion` – currently `1`.
  - `organizationName` – issuer name displayed in Wallet.
  - `passTypeIdentifier` – your Pass Type ID.
  - `serialNumber` – unique per pass.
  - `teamIdentifier` – Apple Developer Team ID.
- **Style-specific dictionary:** one of `eventTicket`, `storeCard`, `coupon`, `boardingPass`,
  or `generic`, containing labeled fields (`primaryFields`, `secondaryFields`, etc.).
- **Optional context:**
  - `locations` – latitude/longitude to surface the pass on the lock screen.
  - `relevantDate` – key timestamp for relevance.
  - `barcodes` or `nfc` – how the pass is redeemed.

Sketch (simplified event ticket):

```json
{
  "description": "Gymkhana Live Event Ticket",
  "formatVersion": 1,
  "organizationName": "Gymkhana",
  "passTypeIdentifier": "pass.com.example.gymkhana.event",
  "serialNumber": "TICKET-12345",
  "teamIdentifier": "ABCDE12345",
  "eventTicket": {
    "primaryFields": [
      { "key": "event", "label": "Event", "value": "Gymkhana Live" }
    ],
    "secondaryFields": [
      { "key": "date", "label": "Date", "value": "2025-12-01 19:30" }
    ]
  }
}
```

Interview notes:

- Emphasize uniqueness of `serialNumber` and consistent `passTypeIdentifier`.
- Mention that you can add `backgroundColor`, `foregroundColor`, and `labelColor` for theming.

## 4. Prepare Assets

A pass bundle includes images alongside `pass.json`. Common assets:

- `icon.png`, `icon@2x.png` – required; small icon that appears in lists.
- `logo.png`, `logo@2x.png` – branding at the top of the pass.
- `strip.png`, `strip@2x.png` – horizontal strip image for some pass styles.
- `background.png`, `background@2x.png` – optional background artwork.

Design points to mention:

- Keep images high-contrast and test in both light and dark environments.
- Use the Human Interface Guidelines for Wallet to avoid clutter and ensure legibility.

## 5. Sign and Package the Pass (.Pkpass)

To become a `.pkpass` file:

1. Put `pass.json` and assets into a directory.
2. Create `manifest.json`:
   - Keys: file names.
   - Values: SHA-1 hashes of each file’s contents.
3. Sign `manifest.json` with your Pass Type ID certificate:
   - Result: a CMS signature file, usually named `signature`.
4. Zip everything:
   - Contents: `pass.json`, `manifest.json`, `signature`, and asset files.
   - Extension: `.pkpass`.
   - MIME type: `application/vnd.apple.pkpass`.

In interviews, you can describe this as:

- “A signed zip file where Wallet verifies the manifest and signature before accepting it.”

## 6. Distribute Passes

Common distribution patterns:

- **In-app (PassKit):**
  - Download or generate a `.pkpass` payload.
  - Construct `PKPass(data:)` on-device.
  - Present `PKAddPassesViewController` (UIKit) or `AddPassToWalletButton` (SwiftUI).
- **Web or email:**
  - Host the `.pkpass` file at a URL.
  - Link it with the Add to Apple Wallet badge.
  - When opened on iOS, the Wallet add sheet appears.

Key design practices:

- Use system-branded UI (Add to Wallet buttons) for trust and consistency.
- Make passes usable without requiring the app when that makes sense (web/email flows).

## 7. App Integration with PKPass and PKPassLibrary

Once passes exist, your app typically needs to:

- Check whether the pass is already in Wallet.
- React when passes are added, updated, or removed.

Patterns to describe:

- Use `PKPassLibrary` to query and filter passes by `passTypeIdentifier`.
- Observe `PKPassLibraryDidChange` notifications to refresh UI when Wallet changes.

Tie-ins for interviews:

- Show that you understand the split between **authoring + signing** (often a server concern) and
  **presentation + usage** (app and Wallet).
- Mention entitlements and Pass Type IDs as the gatekeepers for what your app can see and modify.

## 8. What to Emphasize in An Interview

When asked “How would you create a Wallet pass?” touch on:

- Choosing the right pass style for the user experience you want.
- Structuring `pass.json` with required identifiers, fields, and relevance info.
- Signing and packaging `.pkpass` bundles with a Pass Type ID certificate.
- Using PassKit UI (`PKAddPassesViewController`, `AddPassToWalletButton`) rather than custom UI.
- Respecting security and privacy:
  - Certificates and keys are protected.
  - Pass contents reveal only what is necessary for the scenario.

Then, if time allows, connect this to more advanced topics:

- Identity and Verify with Wallet (<doc:apple-wallet-requesting-identity-data-design>).

## 9. Practical Signing Lessons and Pitfalls

From actually signing real passes, a few details matter more than they first appear:

- **Certificate vs identity:**
  - A downloaded `.cer` file is only the public certificate. You cannot sign with it unless the
    matching private key exists in your keychain.
  - In practice, you must create the Pass Type ID certificate from a CSR generated on the same Mac
    (or environment) that will sign passes so the private key is present locally.
  - In Keychain Access, you want to see `Pass Type ID: …` under **My Certificates** with a private
    key attached; otherwise signing will silently fall back to the wrong identity.

- **Use the correct signing identity:**
  - When using `security cms -S`, the `-N` argument must reference the Pass Type ID identity
    (for example, `Pass Type ID: pass.wrkstrm.gymkhana`), not your generic “Apple Development”
    code-signing cert.
  - If you sign with the wrong identity, the `.pkpass` file will look valid as a zip, but Wallet
    will not recognize it and will not offer an Add to Wallet option.

- **Install the WWDR G4 intermediate:**
  - Make sure the **Apple Worldwide Developer Relations Certification Authority G4** certificate is
    installed in your keychain (System or login). Without it, some signing setups can fail or
    produce passes that Wallet will not trust.

- **Test on-device via Safari or Mail:**
  - AirDrop or email the `.pkpass` to an iPhone and open it from Safari or Mail, not just Files.
  - Files may only show a generic “Pass” preview; Safari/Mail will actually hand it to Wallet and
    surface any error messages.

- **Prefer backend signing for production:**
  - For demos, a local script that builds `manifest.json` and calls `security cms -S` is fine.
  - For production, move signing behind a backend service that:
    - Owns the Pass Type ID keys.
    - Validates requests and audit-logs issued passes.
    - Returns a ready-to-use `.pkpass` for the app to present with PassKit UI.
