# Behavioral

@Metadata {
  @TitleHeading("Behavioral Interview Prep")
  @PageColor(green)
  @PageImage(purpose: icon, source: "behavioral-icon.codex", alt: "Behavioral icon")
  @PageImage(purpose: card, source: "behavioral-card.codex", alt: "Behavioral card")
}

@Image(source: "behavioral-hero.codex", alt: "Behavioral hero")

## Story Prep

- Build 6-8 stories using STAR: impact, constraints, tradeoffs, and metrics.
- Include both technical depth (performance wins, reliability fixes) and collaboration examples.
- Keep at least one failure or learning story; be explicit about what changed afterward.

> Tip: Keep a small bank of 6-8 STAR stories and practice telling each one in 2-3 minutes so you
> can adapt them on the fly without rambling.

## CARL Story Architecture (Core Stories)

You will not read a story verbatim in an interview, but you will perform better if you build a
structured narrative in advance. The goal is to walk in with a story scaffold so your delivery is
confident, paced, and consistent under pressure.

### Build Core Stories "Inside Out"

Start with Actions, then expand outward. This is the most reliable way to keep your narrative
anchored in decision‑making and execution rather than vague context.

- **Table of contents first**: for senior‑level stories, draft a short outline of action themes so
  you can deliver a long project clearly.
- **Mini‑CARLs per theme**: write a short Context → Action → Result → Learning for each theme so
  every segment stands on its own.
- **Minimal context pass**: add only the background needed to raise stakes and clarify constraints.
- **Close with Results + Learnings**: make outcomes measurable and call out what changed in your
  approach afterward.

### Organizing Action Themes

When your story is long, the action section is the hardest to keep digestible. One strong option is
to organize actions chronologically:

- **Chronological phases**: structure the action section by project phase (discovery, build, ship,
  stabilize).
- **Phase‑specific decisions**: call out a key decision and tradeoff in each phase.
- **Smooth transitions**: use phase changes as natural transitions so the interviewer can track
  progress without effort.

## Action Sequencing Styles (Chronological vs Thematic)

Long stories need a deliberate action structure. Choose a sequencing style that supports the
message you want to land and makes the story easy to follow.

### Chronological Actions (Phase‑based Narrative)

Chronological delivery is the default because it mirrors how projects actually unfold. It works
especially well when the project has clear phases and your actions are distinct within each phase.

Example phase outline:

- **Discovery**: research, early risk surfacing, and initial framing.
- **Alignment**: leadership buy‑in, budget or resourcing, and stakeholder coordination.
- **Design**: architecture or UX constraints, prototypes, and tradeoff calls.
- **Implementation**: execution and technical problem solving.
- **Rollout**: staged launch, guardrails, and operational coordination.

### Thematic Actions (Signal‑based Narrative)

Sometimes the most important signal doesn’t appear until late in the project. A thematic structure
lets you lead with the strongest signal first and group actions by the message you want the
interviewer to remember.

Use thematic delivery when:

- **Your biggest impact occurs late** and you want to lead with it.
- **You need to brand yourself** with specific attributes (e.g., “I’m the person who de‑risks
  launches”).
- **Your actions are distributed** across time but share the same decision pattern.

### Choosing the Right Structure

If you want clarity and a sense of progression, go chronological. If you want to control the
signals and prioritize your strongest moments, go thematic. Pick one approach and commit to it so
the story feels intentional rather than improvised.

## Meta Behavioral Loop (STAR Focus)

Meta looks for ownership, speed with rigor, and cross‑functional clarity. Anchor every story in
measurable impact and decision quality, not just effort.

### Meta Signal Map

- **Impact**: tie to metrics (latency, crash rate, revenue, retention, cost).
- **Ownership**: you drove clarity, unblocked progress, and made calls under ambiguity.
- **Execution**: you shipped quickly without sacrificing quality or safety.
- **Influence**: you aligned PM/design/infra and handled disagreement productively.
- **Learning**: you surfaced what you changed afterward and how you prevent repeats.

### STAR Template Tuned for Meta

- **Situation**: name the high‑stakes context and the constraint (time, scale, risk).
- **Task**: your specific responsibility and success criteria.
- **Action**: 2-3 decisive moves, tradeoffs, and why you chose them.
- **Result**: quantify outcome and include a before/after comparison.
- **Reflection**: what you would do differently and how you institutionalized the learning.

### Story Bank (6-8 Total)

- **Scale + reliability**: outage, perf regression, or data loss risk.
- **Product impact**: feature that moved a meaningful business or user metric.
- **Ambiguity**: unclear goal, conflicting stakeholders, or missing requirements.
- **Conflict**: disagreement resolved with data or principled negotiation.
- **Failure**: a decision that didn’t work, with accountability and correction.
- **Leadership**: mentoring, setting standards, or driving a technical RFC.

## Meta STAR Story Bank (Drafts)

Use these as templates. Replace the metric placeholders with your real numbers.

## 2-Minute and 4-Minute Story Versions

Use the 2-minute version for tight rounds. Use the 4-minute version when the interviewer asks for
depth or when you need to compensate for a weak coding round.

### 1) Cross-org iOS 13 Readiness (Scale + Reliability)

**2-minute version**
- Situation: iOS 13 changes threatened stability across multiple teams.
- Task: coordinate readiness and ship with minimal regressions.
- Action: aligned 20+ engineers, triaged bugs, set release gates.
- Result: **[N]** critical issues resolved, **[X]%** crash/regression reduction, shipped **[Y]**
  weeks earlier.
- Reflection: created a cross-team readiness checklist.

**4-minute version**
- Situation: iOS 13 introduced breaking changes across dependencies and UI frameworks.
- Task: deliver a safe, on-time release across 6+ teams.
- Action:
  - Built tracking and ownership across 20+ engineers.
  - Drove priority triage and expedited a dependency release.
  - Coordinated QA timing and release gates.
- Result: **[N]** blockers cleared, **[X]%** crash reduction, launch unblocked by **[Y]** weeks.
- Reflection: standardized release readiness playbooks.

### 2) Reserve-a-Table Launch (Product Impact + Influence)

**2-minute version**
- Situation: marketing deadline required a new Placesheet action.
- Task: deliver cross-team API + UX changes fast.
- Action: negotiated server changes, built iOS flow, aligned rollout.
- Result: **[N]** interactions/week, **[X]%** engagement lift.
- Reflection: documented a launch template.

**4-minute version**
- Situation: high-visibility campaign needed a new action under a tight deadline.
- Task: align PM/UX/server and ship the full feature.
- Action:
  - Mapped constraints with backend and created API changes.
  - Implemented the iOS flow and validation UX.
  - Coordinated rollout, metrics, and guardrails.
- Result: **[N]** interactions/week, **[X]%** engagement lift, shipped on schedule.
- Reflection: formalized cross-team launch sequencing.

### 3) Shared FAB Infrastructure (Leadership + Quality)

**2-minute version**
- Situation: multiple FAB implementations caused UI bugs.
- Task: design a shared, safe pattern.
- Action: shipped a modular FAB framework and mentored adopters.
- Result: **[N]** features adopted, **[X]%** bug reduction, **[Y]%** interaction lift.
- Reflection: optimized for adoption and docs.

**4-minute version**
- Situation: FAB logic scattered across view controllers, creating regressions.
- Task: unify the pattern without blocking teams.
- Action:
  - Built a state-driven FAB framework.
  - Reviewed and mentored adoption across teams.
  - Refactored high-risk screens first.
- Result: **[N]** features adopted, **[X]%** bug reduction, **[Y]%** interaction lift.
- Reflection: learned how to drive infra adoption with minimal friction.

### 4) Production Login Incident (Reliability + Judgment)

**2-minute version**
- Situation: 403 errors blocked login for some users post-release.
- Task: restore login reliability quickly.
- Action: identified backend IP blacklist issue, recommended rollback path.
- Result: login success **[X]%**, crash-free **[Y]%**.
- Reflection: added a rollback decision tree.

**4-minute version**
- Situation: new 403s surfaced after a release, blocking login for a subset of users.
- Task: isolate root cause and restore reliability without a full rollback.
- Action:
  - Traced failure to backend IP blacklist behavior.
  - Recommended a temporary forwarder path.
  - Improved analytics to reflect the true login funnel.
- Result: login success **[X]%**, crash-free **[Y]%**, incident closed in **[Z]** hours.
- Reflection: codified incident response steps for auth.

### 5) Networking Refactor After Outage (Ownership + Architecture)

**2-minute version**
- Situation: prior outage exposed fragile networking tech debt.
- Task: propose a safer architecture without breaking legacy services.
- Action: introduced protocol boundaries and incremental migration.
- Result: **[X]%** faster endpoint integration, **[N]** teams unblocked.
- Reflection: favored incremental refactors over rewrites.

**4-minute version**
- Situation: monolithic networking client caused a 90-minute outage.
- Task: reduce risk while keeping existing services stable.
- Action:
  - Designed protocol-oriented boundaries and isolated session management.
  - Standardized error handling and request creation.
  - Planned a phased rollout to minimize regressions.
- Result: **[X]%** faster integration, **[N]** teams supported, fewer regressions.
- Reflection: created a roadmap for safe platform evolution.

### 6) Swift Rewrite with Stronger Typing (Execution + Quality)

**2-minute version**
- Situation: 2.0 release required a full Swift rewrite.
- Task: ship on time while raising quality.
- Action: added Swift model parsing and protocol-driven data sources.
- Result: **[X]%** boilerplate reduction, crash-free **[Y]%**.
- Reflection: documented shared patterns for future teams.

**4-minute version**
- Situation: major release with a full Swift rewrite across modules.
- Task: deliver quickly without sacrificing stability.
- Action:
  - Built typed parsing and protocol-based data sources.
  - Added code review protocols for integration clarity.
  - Coordinated shared abstractions across teams.
- Result: **[X]%** boilerplate reduction, crash-free **[Y]%**, largest release shipped.
- Reflection: codified practices into team guidelines.

### 7) Shorts TTS Editor Delivery (YouTube) (Execution + Reliability)

**2-minute version**
- Situation: Shorts editor needed text-to-speech features delivered quickly and safely.
- Task: ship TTS end-to-end with testing and a reliable network path.
- Action: built the TTS networking service, added track composition, wired UI controls, and added
  unit tests for the feature controller.
- Result: feature shipped with **[X]%** crash-free rate and **[Y]**% adoption/usage.
- Reflection: prioritized test seams and feature flags for safe rollout.

**4-minute version**
- Situation: Shorts editor needed new TTS capabilities across networking, media, and UI.
- Task: deliver a stable TTS experience without regressing editor reliability.
- Action:
  - Implemented a TTS networking service and requestor for backend calls.
  - Added TTS track composition and preview flows.
  - Integrated UI entry points and added unit tests to harden behavior.
- Result: shipped the feature with **[X]%** crash-free rate and **[Y]**% usage lift.
- Reflection: reinforced the pattern of shipping with tests + gating for creator tools.

### 8) Shorts Editor Test Failure (Swizzling Crash) (Reliability + Debugging)

**2-minute version**
- Situation: a functional test for camera → editor navigation crashed due to swizzling.
- Task: restore test stability without masking real defects.
- Action: identified the swizzle target mismatch and load-order issue; stabilized the test harness.
- Result: restored test pass rate to **[X]%** and unblocked CI in **[Y]** hours.
- Reflection: moved toward dependency injection to reduce brittle swizzling.

**4-minute version**
- Situation: `YTShortsCreationFunctionalTest` failed with a swizzling assertion during export.
- Task: diagnose the root cause and prevent repeat failures.
- Action:
  - Verified selector availability and signature match.
  - Fixed swizzle target to the correct class and ensured load order.
  - Added safety checks to avoid double-swizzle in tests.
- Result: CI stabilized (**[X]%** pass rate) and reduced flaky failures by **[Y]%**.
- Reflection: documented safer test‑double patterns and swizzle guardrails.

### 1) Cross-org iOS 13 Readiness (Scale + Reliability)

- **Situation**: iOS 13 introduced platform changes that threatened stability across multiple teams.
- **Task**: coordinate cross‑org readiness, triage bugs, and ship with minimal regressions.
- **Action**:
  - Built a shared tracking system and coordinated 20+ engineers across 6+ teams.
  - Drove bug ownership, expedited a critical dependency fix, and aligned QA timing.
  - Prioritized high‑impact risks and set release gates.
- **Result**: shipped iOS 13 compatibility with **[N]** critical issues resolved and **[X]%**
  reduction in crash rate or regressions; unblocked release by **[Y]** weeks.
- **Reflection**: institutionalized a cross‑team readiness playbook and release checklist.

### 2) Reserve‑a‑Table Launch (Product Impact + Influence)

- **Situation**: a marketing deadline required a new Placesheet action with API and UX changes.
- **Task**: deliver the feature end‑to‑end and coordinate PM/UX/server changes fast.
- **Action**:
  - Mapped constraints with server teams and negotiated API changes.
  - Implemented the iOS feature and partner workflows under deadline pressure.
  - Aligned stakeholders on rollout and success criteria.
- **Result**: shipped on time; drove **[N]** interactions/week and **[X]%** lift in engagement.
- **Reflection**: created a reusable launch template for cross‑team features.

### 3) Shared FAB Infrastructure (Leadership + Quality)

- **Situation**: inconsistent floating action button implementations were causing UI bugs.
- **Task**: design a shared pattern that multiple teams could adopt safely.
- **Action**:
  - Built a modular state‑driven FAB framework and documented usage.
  - Mentored teams adopting the new pattern and reviewed their CLs.
  - Refactored high‑risk screens to the shared API.
- **Result**: adoption by **[N]** features; **[X]%** reduction in FAB‑related bugs; improved
  interaction rate by **[Y]%**.
- **Reflection**: learned to prioritize adoption paths and developer ergonomics.

### 4) Production Login Incident (Reliability + Judgment)

- **Situation**: new 403 errors blocked logins for some users after a release.
- **Task**: isolate root cause and restore reliable login quickly.
- **Action**:
  - Investigated backend IP blacklist behavior and client traffic patterns.
  - Recommended a rollback to a stable forwarder path while debugging.
  - Improved analytics to match the actual login experience.
- **Result**: restored login success to **[X]%** and stabilized crash‑free rate at **[Y]%**.
- **Reflection**: formalized a rollback decision tree for authentication issues.

### 5) Networking Refactor After Outage (Ownership + Architecture)

- **Situation**: a prior outage exposed high‑risk tech debt in a monolithic networking client.
- **Task**: propose a safer architecture that preserved legacy services.
- **Action**:
  - Introduced protocol‑oriented boundaries and isolated session management.
  - Reduced ad‑hoc request handling and standardized error paths.
  - Planned an incremental migration to avoid breaking existing endpoints.
- **Result**: reduced regression risk, shortened new endpoint integration by **[X]%**, and
  enabled **[N]** teams to ship safely.
- **Reflection**: reinforced incremental migration over big‑bang rewrites.

### 6) Swift Rewrite with Stronger Typing (Execution + Quality)

- **Situation**: the 2.0 release required a full Swift rewrite across major app modules.
- **Task**: ship on time while improving safety and maintainability.
- **Action**:
  - Added Swift model parsing and protocol‑driven data sources.
  - Implemented code review protocols to reduce integration errors.
  - Coordinated across teams to align on shared abstractions.
- **Result**: reduced boilerplate by **[X]%**, improved crash‑free rate to **[Y]%**, and
  shipped the largest release to date.
- **Reflection**: codified best practices for future feature teams.

### Answer Pacing (2-3 Minutes)

- 20–30 sec: Situation + Task
- 60–90 sec: Action (decisions, tradeoffs, validation)
- 30–45 sec: Result + Reflection

### Example Answer Outline (Meta‑ready)

- **Situation**: “Payments latency jumped 40% after a schema change two days before a launch.”
- **Task**: “Own mitigation, keep checkout success rate above 98%.”
- **Action**:
  - “Rolled back the index change in a guarded migration.”
  - “Added a targeted query cache and instrumented p95 latency dashboards.”
  - “Negotiated a phased rollout with PM to reduce blast radius.”
- **Result**: “p95 dropped from 1.9s to 900ms, conversion stabilized at 98.6%.”
- **Reflection**: “We added a pre‑deploy perf gate and a rollback playbook.”

### Follow‑up Handling

- If asked “Why not X?”, show the alternative and the constraint that disqualified it.
- If asked “What would you do now?”, give a next‑step that compounds impact.
- If asked “What did you learn?”, state a concrete process or tooling change.

### Common Meta Pitfalls

- Vague impact: always include numbers or clear before/after effects.
- Over‑indexing on heroics: emphasize process, team alignment, and risk control.
- Long setup: keep the setup short so you can show the decision‑making.

## Answering Style

- Lead with the situation and constraint, then actions and measurable results.
- Call out how you validated outcomes (tests, dashboards, user feedback).
- Mention risk management and how you ensured reversibility.
- Keep answers concise (2-3 minutes) and check for follow-up areas.

## Signals to Emphasize

- Product sense: why the work mattered, alternatives rejected, and user impact.
- Quality: tests you added, monitoring, rollbacks, and documentation.
- Teamwork: alignment habits (RFCs, design reviews), mentoring, cross-team handoffs.
- Ownership: how you prioritize, renegotiate scope, and communicate delays early.

## Dramaturgical Model for Behavioral Answers

- Dramaturgical view: life has a **front stage** (the roles you perform in public) and a **back
  stage** (private space where you drop the act, reflect, and prepare).
- **Impression management** is the tool you use to shape how others see you on each front stage
  (teammate, volunteer, student, partner) while staying anchored to your real values backstage.
- Multiple front stages require different scripts:
  - Example: team captain getting everyone fired up before a game.
  - Example: hospital volunteer focused on listening, empathy, and patient comfort.
  - Example: student meeting a professor, showing curiosity and follow-through while seeking a
    recommendation.
- Backstage is your **dojo**: where you rehearse stories, try on explanations, and tune your tone so
  that your front-stage performance is calm, clear, and still authentic.
- Interview framing: explain how you deliberately prepare backstage (reflection, practice,
  feedback) so that in the interview front stage you can adapt to the audience (PM vs engineer vs
  manager) without faking your values.
