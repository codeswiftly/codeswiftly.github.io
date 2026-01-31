@PageImage(purpose: card, source: "companies-meta-meta-post-interview-1-cram-card.codex", alt: "Placeholder card")
@Image(source: "companies-meta-meta-post-interview-1-cram-hero.codex", alt: "Placeholder hero")
@PageImage(purpose: icon, source: "companies-meta-meta-post-interview-1-cram-icon.codex", alt: "Placeholder icon")
# Meta Post-Interview 1: Tactical Cram Sheet

@Metadata {
  @TitleHeading("Meta Post-Interview 1: Tactical Cram Sheet")
  @PageColor(purple)
}

**Use this page for the 20-minute prep before Round 2.**

## 1. The "Say it First" Invariants

Before writing a single line of code, say these two sentences to the interviewer:

> "I will maintain an input pointer that **only moves forward**; I never look backward."
> "My success condition is that I must **fully consume the input** (pointer == count) and process all requirements."

## 2. The "Running Out of Time" Verbal Script

If you are low on time, stop coding and dictate this exact logic. It counts as a pass if clear.

1.  **State State:** "I keep an integer index `j` into the input array."
2.  **State String Logic:** "For a string token, I check if the characters at `j` match the token. If yes, I **advance `j` by the string's length**."
3.  **State Number Logic:** "For a number `n`, I verify `j + n <= input.count` (bounds check). If safe, I **advance `j` by `n`**."
4.  **State End Condition:** "I return true **only if `j == input.count`** at the end."

## 3. Preferred Skeleton: Tokenize + Match (Character Array)

Use `[Character]` to avoid `String.Index` complexity. Break it into two phases.

```swift
import Foundation

enum Token {
    case string(String)
    case number(Int)
}

func solve(pattern: String, input: String) -> Bool {
    // Phase 1: Tokenize
    let tokens = tokenize(pattern)
    
    // Phase 2: Match (The Critical Part)
    let s = Array(input)
    var j = 0 // Input pointer
    
    for token in tokens {
        switch token {
        case .string(let literal):
            let lit = Array(literal)
            // 1. Bounds check
            guard j + lit.count <= s.count else { return false }
            // 2. Content check
            for k in 0..<lit.count {
                guard s[j + k] == lit[k] else { return false }
            }
            // 3. Advance
            j += lit.count
            
        case .number(let n):
            // 1. Bounds check (>= length)
            guard j + n <= s.count else { return false }
            // 2. Advance
            j += n
        }
    }
    
    // Phase 3: Exact consumption check
    return j == s.count
}
```

## 4. Swift API "No-Typecheck" Cheat Sheet

| Task | Code / API | Note |
| :--- | :--- | :--- |
| **Get Digit** | `char.wholeNumberValue` | Returns `Int?`. Preferred/Robust. |
| **Get Digit (Alt)** | `Int(String(char))` | Returns `Int?`. Acceptable in interview. |
| **Is Digit?** | `char.isNumber` | Check before parsing if needed. |
| **Char Array** | `Array(string)` | Returns `[Character]`. Best for indexing. |
| **Append Char** | `str.append(char)` | Or `str + String(char)` |
| **Stack Pop** | `stack.popLast()` | Returns `Element?`. **Always pop before modifying.** |
| **Stack Peek** | `stack.last` | Returns `Element?`. |

### Common Trap: `Int(Character)`
❌ `Int(c)` does **not** compile.
✅ `c.wholeNumberValue!` or `Int(String(c))!`

## 5. Adversarial Micro-Checklist

Mentally run these 3 cases before verifying your code:

1.  **Trailing Input:** Pattern matches early, but input has extra chars (`"a"`, `"ab"`). -> Must return `false` (via `j == count`).
2.  **Exact Boundary:** Skip length equals remaining length. -> Must return `true` (via `<=`).
3.  **Zero/Leading Zero:** `i0n` -> Decide if allowed.

## 6. Debuggable Guard Ladder

If writing logic with complex boolean conditions (like Rect containment), unroll it:

```swift
// ❌ Bad (Hard to debug/blame)
return A && B && C && D

// ✅ Good (Blamable, distinct breakpoints)
guard A else { return false }
guard B else { return false }
guard C else { return false }
guard D else { return false }
return true
```
