# Apple


@Metadata {
  @TitleHeading("Review Apple")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


## Overview

- Scope: DocC stewardship patterns and interview prep pointers.

## Device-First Prep

- Use <doc:os-device-interview-prep> as your primary map for phone, tablet, desktop, wearable,
  TV, and spatial interview drills.
- Rehearse one shared feature and explain what changes per device versus what remains shared core
  logic.

## Wallet Follow-up Plan

- **Rounds:** 5 interviews (45-60 minutes each). Expect Webex sessions with two interviewers per
  slot plus a 30-minute manager wrap-up; a director follow-up may be scheduled later.
- **Focus areas:** coding, agentic AI systems, model evaluations, auto evaluators/LLM judges, data
  generation, training workflows, context engineering, API design, concurrency, data processing,
  algorithms, performance/complexity, and networking.
- **Evaluation themes:** analytical thinking, customer focus, inquisitiveness, innovation,
  problem-solving, communication, and potential for growth beyond the role.
- **Preparation checklist:**
  - Review onsite logistics email (location, attire, timing, Webex links, individual CoderPad URLs).
  - Rehearse clarifying vague prompts; restate requirements before coding.
  - Structure solutions for readability + testability; keep compilation loop tight and narrate debug
    steps if something fails.
  - Practice explaining thought process: requirement -> approach -> implementation -> edge cases ->
    follow-ups. Mention data used for decisions.
- Communication: concise status updates, invite interviewer feedback, share stories showing how you
  influenced others.
- Role fit: be ready to describe how experience scales into other Apple teams.
- Questions to ask: team mission, cross-functional partners, measurement of success, growth path.
- **Concurrency prep:** rehearse actor-based designs, TaskGroup fan-out/fan-in, cooperative
  cancellation, and performance tuning (priorities, avoiding priority inversions).

## Recruiter Notes (Wallet)

- Sample loop structure: multiple Webex sessions (technical + manager chat), all coding via
  provided CoderPad links.
- Topics mirror day-to-day collaboration; interviewers expect candidates to think out loud.
- Role based on campus; logistics and availability handled via recruiter (details kept in private
  bundle).

### Wallet Team Scope

- **Transit:** Express Mode tap-to-ride for global transit systems.
- **Access:** Home/Hotel/Car keys, Magic Mobile, corporate badges.
- **Identity:** Driver's licenses/IDs in Wallet, age verification, TSA use.
- **Provisioning:** Seamless add-to-Wallet and credential migration flows.

### Responsibilities and Partners

- Collaborate on insights, build UI + background processing + networking, and craft frameworks used
  by other Apple teams/external partners.
- Maintain/improve features, focus on fast launches, smooth animations, low power use.
- Partner closely with iOS/macOS/watchOS frameworks, HI designers, Privacy, Server Eng, and
  external partners.

### Wallet Role Posting (Dec 01, 2025 - 200615030)

- **Posting details:**
  - Posted Dec 01, 2025; role number 200615030; 40-hour week.
  - Team charter: ship Wallet features across Transit, Access, Identity, and Provisioning that make
    everyday credentials "just work" with a tap.
- **Day-to-day responsibilities (from JD):**
  - Collaborate on new insights and solutions with cross-functional partners.
  - Build user interfaces, background processing, and networking code.
  - Develop frameworks consumed by other Apple teams and third-party developers.
  - Maintain and improve existing features while shaping new experiences.
  - Deliver fast launch times, fluid animations, and low power usage.
  - Work closely with iOS/macOS/watchOS framework teams, Human Interface, Privacy, Server
    Engineering, and external partners.
- **Minimum qualifications:**
  - Experience developing in Objective-C and/or Swift on iOS.
  - Deep understanding of modern software development methods, architecture, and design.
  - Excellent communication and collaboration skills.
  - Passion for product quality and attention to detail.
  - BS in Computer Science or equivalent education.
- **Preferred qualifications:**
  - macOS and watchOS programming experience.
  - User-interface programming experience.
- **Compensation snapshot:**
  - Base pay range: $147,400-$272,100 depending on skills, experience, and location.
  - Eligible for stock (RSUs + ESPP), bonuses/commissions where applicable, and standard Apple
    benefits (medical, dental, retirement, product discounts, and some tuition reimbursement).

## LeetCode Drills (Apple)

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-273-integer-to-english-words>
- <doc:gaming-deep-dive>

}

Start with integer-to-words for chunking and string assembly, then move into the gaming study
plan for full interview coverage.

### Qualifications Snapshot

- Strong Swift/Objective-C iOS experience; bonus for macOS/watchOS/UI work.
- Depth in modern software architecture, testing, and quality.
- Excellent communication + collaboration; CS degree or equivalent.
- Compensation range: $147,400-$272,100 base + stock/benefits (per JD).

## Palindrome Kata (Swift)

Verifies palindromes while skipping punctuation/whitespace; useful as a warm-up.

```swift
import Foundation

let invalid: [Character] = ["!", ".", " "]

func palindrome(string: String) -> Bool {
  let characters = string.lowercased().compactMap { $0 }
  var begin = 0
  var end = characters.count - 1

  while begin < end {
    var left = characters[begin]
    while invalid.contains(left) {
      begin += 1
      left = characters[begin]
    }

    var right = characters[end]
    while invalid.contains(right) {
      end -= 1
      right = characters[end]
    }

    guard left == right else {
      return false
    }
    begin += 1
    end -= 1
  }
  return true
}

let car = "A Toyota! Race fast... safe car: a Toyota"
print(palindrome(string: car))
```
