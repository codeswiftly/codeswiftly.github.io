# LeetCode 121: Best Time to Buy and Sell Stock

@PageImage(purpose: card, source: "platforms-leetcode-leetcode-121-best-time-stock-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-121-best-time-stock-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-121-best-time-stock-icon.codex", alt: "Placeholder icon")

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-121-best-time-stock-dsa-icon.codex", alt: "Easy problem - Pattern 3 (Sliding Window)")
  @PageImage(purpose: card, source: "leetcode-121-best-time-stock-dsa-card.codex", alt: "Easy problem - Pattern 3 (Sliding Window)")
  @CallToAction(url: "https://leetcode.com/problems/best-time-to-buy-and-sell-stock/", label: "Solve on LeetCode")
}

@Image(source: "leetcode-121-best-time-stock-dsa-hero.codex", alt: "Easy problem - Pattern 3 (Sliding Window)")

Given daily stock prices, buy once and sell once later to maximize profit. Return that maximum (0 if no profit possible).

@Image(source: "leetcode-121-best-time-stock-dsa-top.codex", alt: "Easy problem - Pattern 3 (Sliding Window)")

Solve Easy problem.

## Warnings

@Row {
  @Column {
    > Warning: 1. Use a single pass; avoid O(n^2) brute force.
  }
  @Column {
    > Warning: 2. Handle cases where no profit is possible.
  }
  @Column {
    > Warning: 3. Single pass tracking minimum price so far and best profit.
  }
  @Column {
    > Warning: 4. `1 <= prices.count <= 10^5`.
  }
  @Column {
    > Warning: 5. Time `O(n)`, space `O(1)`.
  }
  @Column {
    > Warning: 6. Monotonically decreasing prices → profit 0.
  }
  @Column {
    > Warning: 7. Single price → 0.
  }
  @Column {
    > Warning: 8. Mention variations: multiple transactions (#122), cooldown (#309).
  }
  @Column {
    > Warning: 9. Discuss handling streaming data (update running min).
  }
  @Column {
    > Warning: 10. What invariant or state do you maintain?
  }
  @Column {
    > Warning: 11. What is the time and space complexity?
  }
  @Column {
    > Warning: 12. Which edge cases would you test first?
  }
  @Column {
    > Warning: 13. How would you optimize for larger inputs?
  }
  @Column {
    > Warning: 14. What alternative approach would you mention and why?
  }
  @Column {
    > Warning: 15. How do you model the state and transitions?
  }
  @Column {
    > Warning: 16. What is the terminal condition or win criteria?
  }
  @Column {
    > Warning: 17. Where can you prune, memoize, or update incrementally?
  }
  @Column {
    > Warning: 18. How would you scale to larger inputs or more players?
  }
  @Column {
    > Warning: 19. Which data structures keep updates fast and traceable?
  }
}
