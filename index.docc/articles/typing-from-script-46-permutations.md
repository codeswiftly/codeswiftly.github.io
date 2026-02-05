# Typing Practice: Script-46-permutations

@PageImage(purpose: card, source: "typing-from-script-46-permutations-card.codex", alt: "Placeholder card")
@PageImage(purpose: icon, source: "typing-from-script-46-permutations-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageColor(blue)
  @TitleHeading("Typing practice: script-46-permutations")
  @PageImage(purpose: icon, source: "cantina-system-design.codex", alt: "Typing practice icon")
}

@Image(source: "typing-from-script-46-permutations-hero.codex", alt: "Typing practice script 46 permutations hero")

This page pulls code blocks directly from script-46-permutations.md and renders them as centered, Xcode‑like typing panels.

## Exercise 1

<div class="typing-container">
  <div class="typing-title">Type the code below</div>
  <div class="typing-editor with-gutter" contenteditable="true" spellcheck="false" aria-label="Typing editor">
<div>/// Backtracking: choose → explore → unchoose.</div>
<div>final class Solution {</div>
<div>  func permute(_ numbers: [Int]) -&gt; [[Int]] {</div>
<div>    var allPermutations: [[Int]] = []</div>
<div>    var currentPath: [Int] = []</div>
<div>    var isUsed = Array(repeating: false, count: numbers.count)</div>
<div></div>
<div>    func depthFirstSearch(_ depth: Int) {</div>
<div>      if depth == numbers.count { allPermutations.append(currentPath); return }</div>
<div>      for index in 0..&lt;numbers.count where !isUsed[index] {</div>
<div>        isUsed[index] = true</div>
<div>        currentPath.append(numbers[index])</div>
<div>        depthFirstSearch(depth + 1)</div>
<div>        currentPath.removeLast()</div>
<div>        isUsed[index] = false</div>
<div>      }</div>
<div>    }</div>
<div>    depthFirstSearch(0)</div>
<div>    return allPermutations</div>
<div>  }</div>
<div>}</div>
  </div>
</div>
