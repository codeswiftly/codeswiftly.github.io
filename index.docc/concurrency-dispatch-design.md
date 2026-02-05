# Concurrent Design with Dispatch

@Metadata {
  @TitleHeading("Review Concurrent Design with Dispatch")
    @PageColor(blue)
}


## Overview

- Goal: practice reasoning about concurrent design using Grand Central Dispatch (GCD) from basic
  queues to more advanced tools like barriers and semaphores.
- Emphasis: choosing the right primitive for the job, avoiding data races and deadlocks, and
  explaining tradeoffs clearly in interviews.

Use this as a complement to Swift concurrency (async/await, actors, Task groups) by showing you
understand the underlying Dispatch patterns.

## Queues and Basic Patterns

- **Queue types:**
  - Main queue: serial, executes UI work on the main thread.
  - Global concurrent queues: concurrent, QoS-based, suitable for CPU-bound or background work.
  - Custom queues: serial or concurrent queues you create for isolating subsystems.
- **Dispatching work:**
  - `async` for non-blocking work; `sync` carefully when you must block the current thread and know
    you are not calling back into the same queue (to avoid deadlocks).
  - Pattern: submit background work to a global or custom queue, then hop back to the main queue
    for UI updates.
- **Design tip:** structure code so each subsystem “owns” a queue; treat that queue as the
  serialization boundary instead of sprinkling locks everywhere.

## Protecting Shared State

Preferred options when you need to manage shared mutable state:

- **Serial queue as a lock replacement:**
  - Keep state private to a type and expose methods that schedule work on a private serial queue.
  - All reads and writes go through that queue, guaranteeing mutual exclusion without manual
    locking.
  - Example:

    ```swift
    final class Counter {
      private var value = 0
      private let queue = DispatchQueue(label: "com.example.counter")

      func increment() {
        queue.async {
          self.value += 1
        }
      }

      func read(completion: @escaping (Int) -> Void) {
        queue.async {
          completion(self.value)
        }
      }
    }
    ```

- **Concurrent queue with barriers:**
  - For read-mostly data, use a concurrent queue:
    - Reads use `async` on the queue.
    - Writes use `async(flags: .barrier)` to ensure exclusive access.
  - This gives high read parallelism while still protecting writes.
  - Example reader–writer cache:

    ```swift
    final class Cache<Key: Hashable, Value> {
      private var storage: [Key: Value] = [:]
      private let queue = DispatchQueue(
        label: "com.example.cache",
        attributes: .concurrent
      )

      func value(for key: Key) -> Value? {
        queue.sync { storage[key] }
      }

      func insert(_ value: Value, for key: Key) {
        queue.async(flags: .barrier) {
          self.storage[key] = value
        }
      }
    }
    ```

- **When to use locks or actors instead:**
  - Very simple critical sections can use a lock for clarity.
  - In new Swift code, actors often replace these patterns; still, knowing the Dispatch equivalents
    lets you reason about existing code and underlying behavior.

## Dispatch Groups

- **Purpose:** coordinate multiple async tasks and know when they all finish.
- **Pattern:**
  - Enter/leave a `DispatchGroup` around async work, or use `group.async` on a queue.
  - Use `notify(queue:)` to schedule a completion block or `wait()` in non-UI code when you must
    block.
- **Interview example:**
  - Fan out N network calls on a global queue, aggregate results in a thread-safe container, then
    call `group.notify` on the main queue to update UI once all are done.

Common fan-out/fan-in shape with `DispatchGroup`:

```swift
let group = DispatchGroup()
var results = [ResultType]()
let queue = DispatchQueue.global(qos: .userInitiated)

for request in requests {
  group.enter()
  queue.async {
    defer { group.leave() }
    if let value = performRequest(request) {
      // Protect shared state, for example via a serial queue or actor.
      DispatchQueue.main.async {
        results.append(value)
      }
    }
  }
}

group.notify(queue: .main) {
  render(results)
}
```

### Example: Batching Watchlist Detail Loads

In Tau's brokers UI, watchlists are loaded in two phases:

1. **Fetch all headers in one call** using a `CommonWatchlistService`:

   ```swift
   let base = try await service.watchlists()
   ```

2. **Fetch details for each watchlist concurrently** using a Swift `TaskGroup` (similar shape to a
   Dispatch group fan-out/fan-in pattern):

   ```swift
   var detailed: [CommonWatchlist] = []
   try await withThrowingTaskGroup(of: CommonWatchlist?.self) { group in
     for wl in base {
       group.addTask {
         do {
           return try await service.watchlist(id: wl.id)
         } catch {
           Log.error("Failed to fetch details for watchlist \(wl.id): \(error.localizedDescription)")
           return nil
         }
       }
     }
     for try await result in group {
       if let full = result { detailed.append(full) }
     }
   }
   ```

Conceptually, this is the same **fan-out/fan-in** shape you would build with `DispatchGroup`: issue
all the requests, then wait for them to complete and aggregate results before updating UI.

## Barriers

- **What they do:**
  - A barrier block (`async(flags: .barrier)`) on a concurrent queue waits until all previously
    submitted blocks finish, runs exclusively, and then allows later blocks to proceed concurrently.
- **Use case:**
  - Reader–writer pattern:
    - Reads: `queue.async { read from shared state }`
    - Writes: `queue.async(flags: .barrier) { mutate shared state }`
  - Good for caches, configuration stores, or in-memory indices with many reads and few writes.
- **Interview framing:**
  - Explain why a barrier on a concurrent queue can outperform a single serial queue when reads are
    much more frequent than writes.
  - Call out that barriers only work on queues you create (not the global concurrent queues).

## Semaphores

- **What they are:**
  - Counting synchronization primitives (`DispatchSemaphore`) with an internal integer that you
    `wait()` (decrement) and `signal()` (increment).
- **Common patterns:**
  - **Limiting concurrency:** start with a semaphore value equal to your max concurrent work (for
    example, 4). Each task waits before starting and signals when done, capping the number of
    simultaneous tasks.
  - **Bridging async to sync:** in legacy code, sometimes used to block until an async callback
    fires. Use sparingly and never on the main queue.
- **Cautions:**
  - Easy to deadlock or starve if `signal()` paths can be skipped.
  - Prefer queues, actors, or higher-level constructs when possible; reach for semaphores only when
    they clearly match the problem (for example, a bounded resource pool).

Example: limit image downloads to four at a time:

```swift
let semaphore = DispatchSemaphore(value: 4)
let group = DispatchGroup()

for url in imageURLs {
  group.enter()
  DispatchQueue.global(qos: .background).async {
    semaphore.wait()
    defer {
      semaphore.signal()
      group.leave()
    }

    downloadImage(from: url)
  }
}

group.notify(queue: .main) {
  reloadCollectionView()
}
```

## Design Patterns to Practice

- **Fan-out/fan-in with bounded concurrency:**
  - Use a global queue for work, a semaphore to bound concurrent tasks, and a group to know when all
    work is done.
  - Discuss tradeoffs vs using Task groups or an `OperationQueue`.
- **Shared cache with fast reads:**
  - Implement cache access using a concurrent queue and barrier writes.
  - Be clear about invariants: all reads see consistent snapshots; writes are serialized.
- **Background work + UI update:**
  - Run CPU-bound or IO-bound work on a background queue, then dispatch back to the main queue to
    update UI.
  - Show awareness of QoS and avoiding main-thread blocking.

## Bonus: Dispatch Source Timers

`DispatchSource` types are lower-level building blocks for reacting to system events such as file
changes, process signals, or timers. For most app code you will not need them, but it helps to know
the basic pattern.

A simple timer using `DispatchSourceTimer`:

```swift
let queue = DispatchQueue(label: "com.example.timer")
let timer = DispatchSource.makeTimerSource(queue: queue)

// Fire immediately, then every second.
timer.schedule(
  deadline: .now(),
  repeating: .seconds(1),
  leeway: .milliseconds(100)
)

timer.setEventHandler {
  print("Tick on queue \(DispatchQueue.currentLabel)")
}

timer.resume()  // Important: sources start in a suspended state.
```

In interviews, you can mention `DispatchSource` as an escape hatch when you need to integrate with
system signals or build custom timer logic, but emphasize that queues, groups, and Swift
concurrency cover most application needs.

## UIKit Animations and Sequencing (WrkstrmKit)

WrkstrmKit adds a small layer on top of `UIViewPropertyAnimator` to keep multi-stage animations
composable and predictable:

- **Model types:**
  - `UIViewAnimation.Options` wraps `duration`, `delay`, `UIView.AnimationOptions`, and an optional
    `hold` time between stages.
  - `UIViewAnimation.Stage` has:
    - `load`: setup work run before the animation begins (for example, layout or initial state).
    - `perform`: the mutation performed inside the animation block.
  - A `UIViewAnimation` instance links a single `Stage` and `Options` and can point to `next` to
    form a chain or loop.

- **Execution via `UIView.perform(_:)`:**

  ```swift
  extension UIView {
    @discardableResult
    public func perform(
      _ animation: UIViewAnimation,
      completion: UIViewAnimation.Completion? = nil
    ) -> UIViewPropertyAnimator {
      let options = animation.options
      let stage = animation.stage

      stage.load?()
      layoutIfNeeded()

      let animations = { [weak self] in
        stage.perform?()
        self?.layoutIfNeeded()
      }

      let finalCompletion: UIViewAnimation.Completion = { [weak self] position in
        guard let self else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + options.hold) { [weak self] in
          guard let self else { return }
          if let next = animation.next, window != nil {
            perform(next, completion: completion)
          } else {
            completion?(position)
          }
        }
      }

      return UIViewPropertyAnimator.runningPropertyAnimator(
        withDuration: options.duration,
        delay: options.delay,
        options: options.timingOptions,
        animations: animations,
        completion: finalCompletion
      )
    }
  }
  ```

- **Concurrency story:**
  - All animation work runs on the main queue (as UIKit expects), but:
    - Stage transitions are sequenced deterministically via `DispatchQueue.main.asyncAfter`.
    - Multi-stage or looping animations are expressed as a chain (`animation.next`), not nested
      closures.
  - You can describe this as a small, composable “animation DSL” that makes it easy to reason about
    time-based behavior and sequencing in interviews.

## How to Explain This in Interviews

- Start with the **problem** (shared state, bounded resources, responsiveness).
- Choose a **Dispatch primitive** (queue, group, barrier, semaphore) and explain why it fits.
- State **invariants** (no data races, upper bound on concurrency, UI not blocked).
- Mention **alternatives** (actors, OperationQueue, higher-level libraries) and when you would
  prefer them in modern Swift code.
