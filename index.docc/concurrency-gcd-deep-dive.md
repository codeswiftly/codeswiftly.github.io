# Mastering iOS Concurrency: A GCD Deep Dive

@Metadata {
  @TitleHeading("Review Mastering iOS Concurrency: a GCD Deep Dive")
}


## Overview

This section builds on the beginner article and focuses on **Grand Central Dispatch (GCD)** as it is
used in real iOS code and interviews.

By the end, you should be able to:

- Explain the difference between concurrency and parallelism with concrete examples.
- Describe how the OS achieves concurrency (time slicing and context switching).
- Choose between `sync`/`async` and serial/concurrent queues and predict the effect on threads.
- Use dispatch groups, work items, barriers, and semaphores in common design patterns.
- Contrast GCD with `OperationQueue` and higher-level Swift concurrency features.

Use this as a mental map when you get open-ended “talk me through how you would design this
concurrent system” questions.

---

## 1. Concurrency vs Parallelism (Mental Models)

**Concurrency** is about *dealing with* multiple tasks at once. On a single core:

- The OS rapidly switches between tasks.
- Each task runs for a short time slice.
- Frequent context switches create the illusion that tasks are progressing together.

Analogy: one bank teller serving two queues by alternating between them quickly.

**Parallelism** is about *doing* multiple tasks at the same time:

- Each task runs on its own core (or hardware resource).
- Work truly progresses simultaneously.

Analogy: two bank tellers, each serving their own queue at the same time.

For iOS interviews:

- Concurrency explains *responsiveness* (UI stays smooth while work happens).
- Parallelism explains *throughput* (how much CPU work you can do per unit time).

---

## 2. OS Fundamentals: Time Slicing and Context Switching

You rarely talk about registers in an interview, but it helps to know the basics.

- **Time slicing**
  - The scheduler gives each runnable thread a fixed time quantum.
  - When the slice expires, the thread is preempted and another gets a turn.
- **Context switching**
  - When a thread is paused, the OS saves its registers, stack pointer, and program counter.
  - To resume another thread, the OS restores that thread’s context.

Because context switches happen many times per second, a single-core device can interleave work and
make multiple tasks *appear* to run at the same time.

In interviews, you can summarize this as:

> “Concurrency is implemented via time slicing and context switching. GCD and Swift concurrency sit
> on top of that machinery.”

---

## 3. GCD Fundamentals: Tasks, Queues, and the Worker Pool

Grand Central Dispatch gives you:

- A way to package work as closures (tasks).
- Dispatch queues that define *where* and *in what order* work runs.
- A worker pool of threads that execute queued tasks.

Two axes matter for every dispatch:

1. **Manner of execution** – `sync` vs `async`
   - Affects the **calling thread**.
2. **Order of execution** – serial vs concurrent queues
   - Affects the **destination queue**.

You can often debug or explain a bug just by walking through those two choices.

---

## 4. Submission Type: Synchronous vs Asynchronous

**Rule of thumb:** `sync`/`async` is about the *caller*, not the queue.

- `sync` (“wait for me”)
  - The caller blocks until the closure finishes.
  - No further work runs on that thread until the block completes.
  - Dangerous on the main queue (classic deadlock: `DispatchQueue.main.sync` from main).
- `async` (“do this later”)
  - The caller does not wait.
  - The closure is queued and will run when the queue has capacity.
  - This is how you keep the main thread responsive.

Interview phrasing:

> “Sync blocks the current thread; async lets it continue. The queue might still be serial or
> concurrent underneath, but that is a separate decision.”

API example:

```swift
let queue = DispatchQueue(label: "com.example.work")

// Synchronous: blocks the caller until done.
queue.sync {
  print("Do quick work and return a value")
}

// Asynchronous: schedule work and return immediately.
queue.async {
  heavyComputation()
}

print("This line runs immediately after async, not after heavyComputation().")
```

---

## 5. Queue Type: Serial vs Concurrent

**Rule of thumb:** serial/concurrent is about the *queue*, not the caller.

### Serial Queues

- Run one task at a time in FIFO order.
- Simplest way to protect shared mutable state without explicit locks.
- Examples:
  - `DispatchQueue.main`
  - Custom queues without the `.concurrent` attribute

### Concurrent Queues

- Can start multiple tasks without waiting for earlier ones to finish.
- Still dequeue in FIFO order, but execution overlaps.
- Examples:
  - `DispatchQueue.global(qos:)`
  - Custom queues created with `attributes: .concurrent`

Interview framing:

> “I use serial queues as a ‘soft lock’ around shared state, and concurrent queues when I want
> throughput and can tolerate tasks finishing in any order.”

Creating both kinds of queues:

```swift
// Serial queue (default)
let serialQueue = DispatchQueue(label: "com.example.serial")

// Concurrent queue
let concurrentQueue = DispatchQueue(
  label: "com.example.concurrent",
  attributes: .concurrent
)

serialQueue.async {
  // One task at a time executes here.
}

concurrentQueue.async {
  // Can run in parallel with other tasks submitted to the same queue.
}
```

---

## 6. Queue Flavors: Main, Global, and Custom

**Main queue**

- Serial; runs on the main thread.
- Only queue allowed to touch UIKit/AppKit directly.
- UI updates must hop back here.

**Global concurrent queues**

- System-provided concurrent queues selected via `DispatchQueue.global(qos:)`.
- Never run work on the main thread, even with `.userInteractive` QoS.
- Good for CPU-bound and I/O-bound background work.

**Custom queues**

- You create them with a label, optional QoS, attributes, and an optional target queue.
- Serial by default; add `.concurrent` to execute multiple tasks at once.
- Often used to isolate a subsystem (for example, a cache or network client) behind a single queue.

Target queues and QoS:

- Custom queues inherit priority and behavior from their target queue.
- Pointing multiple serial queues at a single serial target is a way to enforce global ordering.

Example: a background worker queue with explicit QoS and target:

```swift
let target = DispatchQueue.global(qos: .userInitiated)

let workerQueue = DispatchQueue(
  label: "com.example.worker",
  qos: .userInitiated,
  attributes: [],
  autoreleaseFrequency: .workItem,
  target: target
)

workerQueue.async {
  performBackgroundTask()
}
```

---

## 7. Coordination: Dispatch Groups and Work Items

### Dispatch Groups

Use a group when you want to:

- Kick off multiple async tasks.
- Run a completion handler once *all* of them finish.

Patterns:

- `group.enter()` before starting async work, `group.leave()` in the completion handler.
- `group.notify(queue:)` for a non-blocking callback.
- `group.wait()` when you must block (never on the main queue).

Interview example:

> “On launch we fetch profile, settings, and feature flags in parallel. Each call enters a group
> before starting and leaves in the callback. Once the group notifies on the main queue, we
> transition from the splash screen.”

Concrete `DispatchGroup` fan-out/fan-in:

```swift
let group = DispatchGroup()
var profiles: [Profile] = []

for id in userIDs {
  group.enter()
  api.fetchProfile(id: id) { result in
    defer { group.leave() }
    if case .success(let profile) = result {
      profiles.append(profile)
    }
  }
}

group.notify(queue: .main) {
  render(profiles)
}
```

### Dispatch Work Items

Encapsulate a closure as a reusable object:

- You can submit it to queues or a group.
- You can cancel it before it starts.

Classic use case: debounced search or username checks.

- Keep a reference to the latest `DispatchWorkItem`.
- On each keystroke:
  - Cancel the previous item.
  - Create a new item that calls the API after a small delay.
  - Schedule it with `asyncAfter` on a background queue.

API sketch:

```swift
final class SearchController {
  private let queue = DispatchQueue(label: "com.example.search")
  private var pendingWorkItem: DispatchWorkItem?

  func userDidType(query: String) {
    pendingWorkItem?.cancel()

    let workItem = DispatchWorkItem { [weak self] in
      self?.performSearch(query: query)
    }
    pendingWorkItem = workItem

    queue.asyncAfter(deadline: .now() + .milliseconds(300), execute: workItem)
  }
}
```

---

## 8. Protecting Shared State: Barriers and Semaphores

The core concurrency bug you are usually fixing is **data inconsistency**:

- Multiple threads access or mutate shared state without coordination.
- You see “weird” crashes, corrupted data, or negative balances.

### Barriers on Concurrent Queues

- Submit a write with `queue.async(flags: .barrier) { ... }` on a custom concurrent queue.
- All prior tasks finish before the barrier runs.
- No other tasks run concurrently with the barrier.

Reader–writer pattern:

- Reads: `queue.async { read(sharedState) }`
- Writes: `queue.async(flags: .barrier) { mutate(sharedState) }`

This gives:

- High read parallelism.
- Serialized writes with no explicit locks.

Full reader–writer example:

```swift
final class InMemoryStore {
  private var storage: [String: String] = [:]
  private let queue = DispatchQueue(
    label: "com.example.store",
    attributes: .concurrent
  )

  func value(for key: String) -> String? {
    queue.sync { storage[key] }
  }

  func set(_ value: String?, for key: String) {
    queue.async(flags: .barrier) {
      self.storage[key] = value
    }
  }
}
```

### Semaphores

- Counting primitive with `wait()` and `signal()`.
- `value = 1` behaves like a mutex: only one thread can hold it.
- `value = N` allows at most `N` concurrent holders.

Use cases:

- Limiting maximum concurrency (for example, at most 4 in-flight downloads).
- Bridging async APIs into sync code (only off the main thread).

Watch out for:

- Deadlocks if some path forgets to call `signal()`.
- Priority inversion when high-priority tasks are blocked behind low-priority holders.

Limiter example:

```swift
let semaphore = DispatchSemaphore(value: 4)
let group = DispatchGroup()

for work in jobs {
  group.enter()
  DispatchQueue.global().async {
    semaphore.wait()
    defer {
      semaphore.signal()
      group.leave()
    }
    perform(work)
  }
}

group.notify(queue: .main) {
  print("All jobs finished")
}
```

---

## 9. Operations vs “Raw” GCD

`Operation` and `OperationQueue` sit on top of GCD and add:

- Explicit state: `isReady`, `isExecuting`, `isFinished`, `isCancelled`.
- Dependencies: `opB.addDependency(opA)`.
- Cancellation and priority APIs.

When to reach for them:

- Complex graphs of work with dependencies.
- You need to observe or cancel in-flight operations.
- You want to reuse encapsulated chunks of work.

Async operations:

- A plain `Operation` is “finished” when `main()` returns.
- For async tasks (for example, network requests), create a subclass that:
  - Overrides `isAsynchronous`, `isExecuting`, and `isFinished`.
  - Manually flips those flags (with KVO) when the async callback completes.

Interview pitfall to call out:

- If `opA.main()` starts a network request and returns immediately, `opA` is considered finished.
- `opB` that depends on `opA` can start *before* the network response arrives.

---

## 10. Putting it Together in Interviews

When you get a concurrency design question, structure your answer around:

1. **Responsiveness**
   - “All UI work stays on the main queue. Anything slow happens on background queues with `async`.”
2. **Shared state**
   - “We isolate mutable state behind a dedicated queue. For read-heavy data, we use a concurrent
     queue with barrier writes.”
3. **Coordination**
   - “We use dispatch groups (or task groups) for fan-out/fan-in patterns and work items for
     debounced or cancelable tasks.”
4. **Correctness**
   - “We avoid deadlocks by not calling `sync` onto the same serial queue and keep blocking calls
     off the main thread.”

Being able to map concrete code back to these principles is what “mastery” looks like in an
interview setting.
