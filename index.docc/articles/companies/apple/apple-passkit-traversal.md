# PassKit Traversal Tracker (Sosumi.Ai)


@Metadata {
  @TitleHeading("Review PassKit Traversal Tracker (Sosumi.Ai)")
}


## Scope

- Source index: `https://sosumi.ai/documentation/passkit`
- Link pattern: pages whose paths start with `/documentation`, resolved as
  `https://sosumi.ai/documentation…`.
- Approximate size: **1,391** `/documentation` links under the PassKit index as of
  2025-12-15 (via `rg` count on the rendered markdown).

This file tracks which PassKit docs have a local raw mirror and which have an API-design summary.

## Conventions

- **Raw mirrors (per doc):**
  - Stored under `apple-passkit-raw/` in this DocC bundle.
  - Filename pattern: `<short-slug>-raw.md` (for example, `wallet-raw.md`).
  - Content: word-for-word copy of the sosumi.ai page for a specific PassKit doc
    (for example, `apple-passkit-raw/wallet-raw.md`).
- **Design / overview pages:**
  - Filename pattern: `apple-wallet-<topic>-...md` or `apple-passkit-<topic>-...md`.
  - Content: curated API design notes, patterns, and interview framing that build on one or more
    raw pages.
- **Status fields:**
  - `raw`: whether we have a local raw mirror for that sosumi path.
  - `design`: whether we have a design/overview page that covers that area.
  - `notes`: quick pointers to local files.

When adding a new page:

1. Create or update the `*-raw.md` file under this DocC bundle.
2. Optionally create a design/overview page.
3. Add or update the corresponding row in the table below.

## Current Coverage

| sosumi path                                   | raw  | design | notes |
|----------------------------------------------|------|--------|-------|
| `/documentation/passkit`                     | ✅   | ✅     | Raw: `apple-passkit-raw/passkit-raw.md`; Overview: `apple-passkit-common-api-practices.md`. |
| `/documentation/passkit/wallet`              | ✅   | ✅     | Raw: `apple-passkit-raw/wallet-raw.md`; Design: `apple-wallet-passkit-wallet-apis.md`. |
| `/documentation/passkit/requesting-identity-data-from-a-wallet-pass` | ✅ | ✅ | Raw: `apple-passkit-raw/requesting-identity-data-from-a-wallet-pass-raw.md`; Design: `apple-wallet-requesting-identity-data-design.md`, `apple-wallet-iso18013-data-processing.md`. |

## Backlog Notes

- The remaining PassKit pages (~1.3k) include:
  - Individual types (classes/structs/enums), especially under `PKPayment*`, `PKPass*`,
    `PKIdentity*`, and extension handlers.
  - Topic guides such as Apple Pay setup, regional compliance, issuer provisioning, and Wallet
    extensions.
- Prioritization suggestions:
  - Start with **topic guides** and **top-level collections** to capture design patterns.
  - Then sample **representative types** in each area (payments, passes, identity, issuer
    provisioning) rather than mirroring every symbol immediately.

As more pages are mirrored, expand the table above and group rows by area (Apple Pay, Wallet passes,
identity, disbursements, issuer extensions, etc.).

## CLI Helper (Carrie Docs)

Use the `carrie-docs` CLI (under `.clia/agents/carrie/spm/local`) to keep this mirror in sync:

- Extract or refresh paths + JSON index:

  ```bash
  swift run --package-path .clia/agents/carrie/spm/local carrie-docs \
    passkit extract-paths
  ```

- Download missing pages into `apple-passkit-raw/` and update `passkit-index.json`:

  ```bash
  swift run --package-path .clia/agents/carrie/spm/local carrie-docs \
    passkit fetch
  ```

- Check mirror status:

  ```bash
  swift run --package-path .clia/agents/carrie/spm/local carrie-docs \
    passkit status
  ```

These commands populate and maintain:

- `code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/apple-passkit-raw/passkit-index.json`
- Raw mirrors under `code/mono/orgs/codeswiftly/public/docc/pages/codeswiftly.github.io/index.docc/apple-passkit-raw/`.
