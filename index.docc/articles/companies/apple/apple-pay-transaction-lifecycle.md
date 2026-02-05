# Apple Pay Transaction Lifecycle

@PageImage(purpose: card, source: "companies-apple-apple-pay-transaction-lifecycle-card.codex", alt: "Placeholder card")
@Image(source: "companies-apple-apple-pay-transaction-lifecycle-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-apple-apple-pay-transaction-lifecycle-icon.codex", alt: "Placeholder icon")

@Metadata {
  @TitleHeading("Review Apple Pay Transaction Lifecycle")
  @PageImage(purpose: icon, source: "apple-pay-transaction-lifecycle-icon.codex", alt: "Apple Pay Transaction Lifecycle icon")
  @PageImage(purpose: card, source: "apple-pay-transaction-lifecycle-card.codex", alt: "Apple Pay Transaction Lifecycle card")
}

@Image(source: "apple-pay-transaction-lifecycle-hero.codex", alt: "Apple Pay Transaction Lifecycle hero")

## Overview

Apple Pay keeps payment credentials off your servers and off the merchant’s device by using a
device-bound network token (DPAN) plus a per-transaction cryptogram.

This article is a high-level mental model for interviews; card networks and issuers implement the
details.

![Apple Pay transaction lifecycle diagram](apple-pay-transaction-lifecycle.codex.svg)

## Actors and Responsibilities

- **Device (Wallet / Secure Element)**: holds the provisioned payment token (DPAN) and produces a
  one-time cryptogram for each authorization attempt.
- **Merchant / PSP**: collects purchase context (amount, items, merchant identity) and submits an
  authorization request using the payment token data returned from Wallet.
- **Acquirer / processor**: routes authorization and later clearing/settlement messages to the
  card network.
- **Card network + token service provider (TSP)**: validates token artifacts, detokenizes (DPAN →
  PAN) for issuer routing, and enforces network/token policy.
- **Issuer**: runs risk checks and returns the approve/decline decision; later posts settlement.

## Phase 1: Authorization (Online)

Authorization is the “can we do this right now?” decision.

- User confirms the payment (Face ID / Touch ID / passcode).
- Wallet returns a **payment token blob** to the merchant app / POS:
  - DPAN (device network token), cryptogram, and metadata.
- Merchant / acquirer / network route the authorization request to the issuer.
- Issuer approves/declines and the decision returns back to the device.

Key interview point: the merchant never gets the real PAN; the device token is validated by the
network + issuer using the cryptogram and token policy.

## Phase 2: Clearing and Settlement (Batch)

Clearing/settlement is the “move money and post it” phase.

- Merchant captures the transaction (immediately or later, depending on the flow).
- Clearing/presentment runs via batch rails between merchant/acquirer/network/issuer.
- Issuer posts the transaction and funds settle across parties.

Key interview point: authorization is interactive and latency-sensitive; settlement is throughput
and correctness-sensitive (idempotency, reconciliation, ledger accuracy).

## Practical Engineering Concerns (What Interviewers Probe)

- **Idempotency**: retries happen everywhere (network, app, PSP). Every step needs stable IDs and
  dedupe logic.
- **State machines**: model the lifecycle explicitly (`authorized → captured → settled → refunded`)
  with clear transitions.
- **Observability**: correlate device-side UX events with backend/payment gateway events.
- **Security**: treat token blobs and any derived identifiers as sensitive; log with redaction.
