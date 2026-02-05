# Wallet and PassKit


@Metadata {
  @PageColor(purple)
  @TitleHeading("Navigate Wallet and PassKit")
  @CallToAction(url: "doc:apple-wallet-interview-guide", label: "Start with the overview")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


Apple Wallet, PassKit workflows, and identity design references.

@Row {
  @Column {
    **Privacy**
    Keep privacy and security requirements in view.
  }
  @Column {
    **Entitlements**
    Never assume device capability or entitlement access.
  }
  @Column {
    **Flow**
    Explain the full identity flow, storage to verification.
  }
}

## Start Here

@Links(visualStyle: detailedGrid) {

- <doc:apple-wallet-interview-guide>
- <doc:apple-wallet-api-design>
- <doc:apple-passkit-common-api-practices>
- <doc:apple-passkit-creating-passes>
- <doc:apple-pay-transaction-lifecycle>
- <doc:apple-wallet-requesting-identity-data-design>
}

## Flow Map

@Row {
  @Column {
    **Overview**
  }
  @Column {
    **Identity design**
  }
  @Column {
    **API surface**
  }
}

@Row {
  @Column {
    **Credential store**
    <doc:apple-wallet-credential-store-design>
  }
  @Column {
    **ISO 18013**
    <doc:apple-wallet-iso18013-data-processing>
  }
  @Column {
    **Nonce + session**
    <doc:apple-wallet-nonce-and-session-design>
  }
}

@Row {
  @Column {
    **Wallet APIs**
    <doc:apple-wallet-passkit-wallet-apis>
  }
  @Column {
    **PassKit core**
  }
  @Column {
    **Apple Pay**
  }
}

## Build the Pass


### Raw Reference

- <doc:passkit-raw-index>
