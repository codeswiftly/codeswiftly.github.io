# Processing Iso 18013-5 Identity Data

@PageImage(purpose: card, source: "companies-apple-apple-wallet-iso18013-data-processing-card.codex", alt: "Placeholder card")
@Image(source: "companies-apple-apple-wallet-iso18013-data-processing-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-apple-apple-wallet-iso18013-data-processing-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Review Processing Iso 18013-5 Identity Data")
  @PageImage(purpose: icon, source: "apple-wallet-iso18013-data-processing-icon.codex", alt: "Processing Iso 18013 5 Identity Data icon")
  @PageImage(purpose: card, source: "apple-wallet-iso18013-data-processing-card.codex", alt: "Processing Iso 18013 5 Identity Data card")
}

@Image(source: "apple-wallet-iso18013-data-processing-hero.codex", alt: "Processing Iso 18013 5 Identity Data hero")

## Overview

- Goal: outline how a backend should process, verify, and consume the ISO 18013-5 payload returned
  from `PKIdentityDocument.encryptedData` when using Verify with Wallet.
- Scope: high-level data processing and verification flow; the ISO 18013-5 and companion specs
  remain the normative source of truth for exact field names, structures, and cryptographic rules.

Use this as a design aid when talking about server-side handling of Wallet identity data.

## Payload and Trust Model

- **Client-side:** your app receives a `PKIdentityDocument` with an `encryptedData` blob plus
  metadata. The client treats this blob as opaque and forwards it to your backend.
- **Backend:** holds keys associated with your merchant identifier and is responsible for:
  - Decrypting the payload.
  - Validating issuer and device signatures.
  - Checking the nonce, timestamps, and requested attributes.
  - Mapping the verified attributes into your own domain model.
- **Standards:**
  - The decoded payload follows ISO 18013-5 for mobile driving licenses (mDL) and related identity
    documents.
  - Depending on the descriptor, additional namespaces like AAMVA (US DMV data) or JP may appear.

Interview framing: the backend is the **root of trust**; the app is just a transport and UX shell.

## Processing Pipeline (Step by Step)

Think of the backend as a small state machine for identity requests:

1. **Receive and log request:**
   - Input: encrypted payload, associated nonce, descriptor type, and any request metadata.
   - Correlate with a server-side session record keyed by the nonce and client identity.
2. **Decrypt the payload:**
   - Use keys bound to your merchant identifier.
   - Fail fast if decryption fails (wrong key, corrupted payload, or replay attempt).
3. **Decode ISO 18013-5 structure:**
   - Parse the decoded bytes (for example, CBOR/COSE structures as defined by the spec).
   - Extract:
     - Document metadata (issuer, document type, validity interval).
     - Device and issuer signatures and their certificates.
     - Namespaced attribute bundles (ISO, AAMVA, JP).
4. **Validate cryptographically:**
   - Verify issuer signature against trusted roots appropriate for the jurisdiction.
   - Verify device signature and tie it to the session and nonce.
   - Confirm:
     - The nonce matches what you generated and stored server-side.
     - The timestamps are within acceptable skew and not expired.
5. **Validate against the original descriptor:**
   - Ensure the attributes present in the payload are a subset of what your descriptor requested.
   - Check that storage-intent constraints you advertised (for example, `.willNotStore`,
     `.mayStore(days:)`) are honored in your own logic.
   - Reject payloads whose attributes do not match the requested document type or namespace.
6. **Map to your internal schema:**
   - Convert spec field names into your own types:
     - Example categories: `AgeVerification`, `Name`, `Address`, `DocumentMetadata`.
   - Derive higher-level facts:
     - For example, `isOver21: Bool` from ISO/AAMVA age fields if not using `age(atLeast:)`
       directly.
   - Drop fields you don’t need; do not mirror the entire ISO structure if it is not required.
7. **Persist and respond:**
   - Store only the attributes your policies and user consents allow, with clear retention periods.
   - Return a compact result to the client, such as:
     - `ageVerified`, `country`, `documentType`, and an internal decision code.

At interview time, walk through these steps explicitly to show you understand the full lifecycle.

## Namespaces and Field Mapping

- **Descriptor-driven expectations:**
  - `PKIdentityDriversLicenseDescriptor` → expect ISO + AAMVA fields (for example, standardized
    license and DMV data).
  - `PKIdentityNationalIDCardDescriptor` → expect ISO + JP-specific extensions.
  - `PKIdentityPhotoIDDescriptor` → expect ISO-only fields.
- **Mapping strategy:**
  - Keep a versioned mapping layer that:
    - Knows which ISO / AAMVA / JP fields to read for each descriptor type.
    - Converts them into your internal, type-safe structures.
    - Handles optional fields and jurisdictional differences gracefully.
- **Versioning:**
  - Track the ISO 18013-5 version and any profile-specific extensions you support.
  - Keep migrations in code so you can add new fields without breaking existing clients.

Design talking point: treat the ISO payload like a wire format; shield the rest of your system
behind a small, well-tested mapping layer.

## Privacy, Retention, and Access Control

- **Least privilege:**
  - Only extract and store attributes that correspond to what your descriptor requested and what
    your UI told the user.
- **Retention:**
  - Implement time-based deletion that respects `.mayStore(days:)` and any higher internal privacy
    bar.
  - For `.willNotStore`, avoid writing those attributes to long-lived storage; restrict them to
    in-memory decisions where possible.
- **Access control:**
  - Protect identity records with strict role-based access.
  - Log and audit access to identity data; consider separate encryption keys and stores for highly
    sensitive fields.

Mention these when asked how you’d design compliant, user-respecting identity data handling.

## Error Handling and Observability

- **Error categories:**
  - Transport errors (network issues between app and backend).
  - Cryptographic errors (decryption/signature failures).
  - Policy errors (descriptor mismatch, unsupported document types, expired documents).
  - System errors (unexpected structures, parsing failures).
- **API surface to the app:**
  - Return high-level, non-leaky error codes (for example, `identityUnavailable`,
    `identityVerificationFailed`, `identityRejectedByPolicy`).
  - Avoid leaking cryptographic or issuer details directly to the user; keep those in logs.
- **Logging and metrics:**
  - Log enough detail (with redaction) to debug spec or integration issues.
  - Track rates of verification success, cancellation, and different error buckets.

This gives you concrete points for “how would you monitor and debug this in production?” questions.

## Testing with Mock MDLs

- Even without live IDs in Wallet, you can:
  - Use simulator / developer profiles to exercise the complete flow end-to-end.
  - Capture sample payloads and use them as fixtures in backend tests.
- Backend tests should cover:
  - Valid signed payload → accepted decision and correct attribute mapping.
  - Tampered payload, wrong nonce, or expired timestamp → rejected with appropriate error.
  - Jurisdiction variations: missing optional fields, extra fields you ignore safely.

Calling this out shows you have a realistic, test-first approach to such a sensitive pipeline.
