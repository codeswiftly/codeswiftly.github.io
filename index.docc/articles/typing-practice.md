# Typing Practice

@PageImage(purpose: card, source: "typing-practice-card.codex", alt: "Placeholder card")
@PageImage(purpose: icon, source: "typing-practice-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageColor(blue)
  @PageImage(purpose: icon, source: "cantina-system-design.codex", alt: "Typing practice icon")
  @TitleHeading("Typing practice")
}

@Image(source: "typing-practice-hero.codex", alt: "Typing practice hero")

Centered, Xcode-like typing area for code drills. No JS required; this page uses DocC-safe HTML + CSS to mimic Xcode’s editor chrome and monospace face.

## Practice: Swift Function Skeleton

<div class="typing-container">
  <div class="typing-title">Complete the function signature and body</div>
  <div class="typing-editor with-gutter" contenteditable="true" spellcheck="false" aria-label="Typing editor">
<div>/// Returns true when all characters are unique.</div>
<div>func allUnique(_ s: String) -&gt; Bool {</div>
<div>    var seen: Set&lt;Character&gt; = []</div>
<div>    for ch in s {</div>
<div>        if !seen.insert(ch).inserted { return false }</div>
<div>    }</div>
<div>    return true</div>
<div>}</div>
  </div>
</div>

### Tips

- Use Option-Arrow to move by words like Xcode.
- Keep lines ≤ 100 columns to match DocC and editor defaults.
- Toggle line numbers by removing the `with-gutter` class.
