# LeetCode 595: Big Countries (SQL)




Return the name, population, and area of countries that have an area >= 3 million square km or population >= 25 million from table `World`.


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
