
@PageImage(purpose: card, source: "platforms-leetcode-leetcode-595-big-countries-card.codex", alt: "Placeholder card")
@Image(source: "platforms-leetcode-leetcode-595-big-countries-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "platforms-leetcode-leetcode-595-big-countries-icon.codex", alt: "Placeholder icon")
# LeetCode 595: Big Countries (SQL)

@Metadata {
  @PageImage(purpose: icon, source: "leetcode-595-big-countries-dsa-icon.codex", alt: "Easy problem - Pattern 1 (Prefix Sum)")
  @PageImage(purpose: card, source: "leetcode-595-big-countries-dsa-card.codex", alt: "Easy problem - Pattern 1 (Prefix Sum)")
}

@Image(source: "leetcode-595-big-countries-dsa-hero.codex", alt: "Easy problem - Pattern 1 (Prefix Sum)")

Return the name, population, and area of countries that have an area >= 3 million square km or population >= 25 million from table `World`.

@Image(source: "leetcode-595-big-countries-dsa-top.codex", alt: "Easy problem - Pattern 1 (Prefix Sum)")

Solve Easy problem.

Return the name, population, and area of countries that have an area >= 3 million square km or
population >= 25 million from table `World`.

## Core Ideas

- Simple `SELECT` with `WHERE` filter combining conditions with `OR`.

## SQL Solution

```sql
SELECT name, population, area
FROM World
WHERE area >= 3000000
   OR population >= 25000000;
```

## Interview Framing

- Discuss why indexes on `area`/`population` help.
- Mention that `OR` may cause index scans; consider rewriting with `UNION` if necessary.
