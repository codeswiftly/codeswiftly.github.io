# A Beginner's Guide to Concurrency in iOS

@PageImage(purpose: card, source: "concurrency-beginners-guide-card.codex", alt: "Placeholder card")

@Metadata {
  @TitleHeading("Review A Beginner's Guide to Concurrency in iOS")
  @PageColor(blue)
  @PageImage(purpose: card, source: "hero-concurrency-beginners.codex", alt: "Concurrency guide hero")
  @PageImage(purpose: icon, source: "concurrency-beginners-guide-icon.codex", alt: "A Beginner s Guide to Concurrency in iOS icon")
}

@Image(source: "concurrency-beginners-guide-hero.codex", alt: "A Beginner s Guide to Concurrency in iOS hero")

## Introduction: Why This Matters for Every iOS Developer

Have you ever used an app that froze while loading data, or seen a crash that seemed to happen at
random? Many of these issues trace back to how an app uses concurrency.

This article builds a mental model for concurrency on Apple platforms so you can write responsive,
stable, and efficient apps. By the end, you should be able to answer:

- What is the real difference between concurrency and parallelism?
- How do synchronous and asynchronous tasks change the way your code runs?
- What is the distinction between serial and concurrent queues?

We will start from the big-picture concepts and work our way down to Grand Central Dispatch (GCD).

---

## 1. The Big Picture: Concurrency vs Parallelism

People often use these terms interchangeably, but they describe different ideas about how work is
executed.

### What Is Concurrency?

Concurrency is about **dealing with multiple tasks at once**, even if a single CPU core can only
execute one instruction at a time.

- On a single-core device, the operating system rapidly switches between tasks.
- Each task runs for a short time slice, then the OS pauses it and resumes another.
- To a human, this fast switching creates the *illusion* that things are progressing together.

Analogy: a single telephone operator handling two callers by switching back and forth between calls.
Each caller feels like the operator is engaged with them, even though only one call is active at
any instant.

### What Is Parallelism?

Parallelism is **true simultaneous execution**: multiple tasks running *at the same time* on
different hardware resources, such as multiple CPU cores.

- Each core can run a separate thread at the same moment.
- This can complete more work in the same amount of wall-clock time (if the work can be split).

Analogy: two bank tellers at two separate counters, each serving their own queue of customers at the
same time.

### Core Differences at a Glance

- **Definition**
  - Concurrency: multiple tasks *in progress* together, with the system interleaving their
    execution.
  - Parallelism: multiple tasks executing *simultaneously* on different cores.
- **Resources**
  - Concurrency: possible even on a single core.
  - Parallelism: requires multiple cores or processing units.
- **Effect**
  - Concurrency: creates the appearance of simultaneous progress.
  - Parallelism: achieves actual simultaneous progress.

In iOS, you care about both:

- Concurrency keeps your app responsive (UI stays smooth while work happens in the background).
- Parallelism helps you scale CPU-bound work across available cores.

---

## 2. The Engine Room: How Concurrency Is Achieved

On a single-core processor, the illusion of concurrency relies on two core mechanisms in the
operating system:

- **Time slicing** – each runnable task gets a small time slot on the CPU before the OS preempts it.
- **Context switching** – when the OS pauses one task and resumes another, it:
  - Saves the current task’s registers, stack, and program counter (its *context*).
  - Restores the next task’s context so it can resume exactly where it left off.

This switch happens many times per second. From a human perspective, a download can progress while
you scroll a list, even though at any exact moment only one instruction is executing on a core.

As an iOS developer you do not manage context switches directly. Instead, Apple gives you higher
level tools built on these primitives. The most fundamental one in the pre–Swift Concurrency world
is **Grand Central Dispatch (GCD)**.

---

## 3. The iOS Toolkit: Grand Central Dispatch (GCD)

Grand Central Dispatch is Apple’s queue-based API for concurrency. Instead of creating and managing
threads directly, you:

1. Package work into **tasks** (closures).
2. Submit those tasks to a **dispatch queue**.
3. Let GCD decide which threads should execute tasks and when.

This design gives you a clean separation of concerns:

- You describe *what* should happen and *in what order*.
- GCD decides *where* to run it (thread pool, cores, QoS).

Minimal example – offloading work from the main thread:

```swift
let backgroundQueue = DispatchQueue.global(qos: .userInitiated)

backgroundQueue.async {
  let result = heavyComputation()

  // Hop back to the main queue for UI updates
  DispatchQueue.main.async {
    resultLabel.text = "Result: \(result)"
  }
}
```

Every GCD decision can be decomposed into two questions:

1. **How** should I submit this work?  
   - Synchronously (`sync`) or asynchronously (`async`) – this affects the *current thread*.
2. **Where** should this work run?  
   - On a **serial** or **concurrent** queue – this affects the *destination queue*.

We will look at these two axes separately.

---

## 4. Manner of Execution: Synchronous vs Asynchronous

The key rule:

> `sync` vs `async` affects the **calling thread**, not the queue itself.

### Synchronous (`Sync`): “Wait for Me”

Submitting work with `sync` means:

- The current thread **blocks** until the submitted closure finishes.
- No further lines of code on that thread run until the work completes.

Conceptually you are saying:

> “Do this work *now* and do not proceed until it is done.”

This is useful when:

- You must perform a small, quick operation and need its result immediately.
- You are absolutely sure you are **not** calling `sync` back onto the same serial queue (which
  would deadlock).

### Asynchronous (`Async`): “Do This Later”

Submitting work with `async` means:

- The current thread **does not wait**.
- The closure is enqueued on the target queue, and the caller immediately continues to the next
  line.

Conceptually you are saying:

> “Please run this work sometime soon, but keep going with what I am doing now.”

This is the default choice for:

- Offloading long-running or blocking work (network, disk, CPU-heavy).
- Scheduling UI updates back on the main queue after background work completes.

In code, `sync` vs `async` looks like this:

```swift
let queue = DispatchQueue(label: "com.example.sync-vs-async")

queue.sync {
  print("A – sync block started and finished before returning")
}

queue.async {
  print("B – async block runs later on the queue")
}

print("C – printed immediately after scheduling async work")
// Guaranteed order: A, C, then B (at some later time).
```

---

## 5. Order of Execution: Serial vs Concurrent Queues

The second axis controls *how the destination queue runs tasks*:

> Serial vs concurrent affects the **queue that executes the work**, not the caller.

### Serial Queues: One at a Time

A serial queue executes **one task at a time** in first-in, first-out (FIFO) order:

- Task 1 starts and finishes.
- Then Task 2 starts and finishes.
- Then Task 3 starts, and so on.

This is perfect when:

- You are protecting shared mutable state without locks (only one task touches it at a time).
- You need predictable ordering (for example, writing log lines or applying migrations).

### Concurrent Queues: Many at Once

A concurrent queue can start multiple tasks without waiting for earlier ones to finish:

- Tasks are still *dequeued* in FIFO order, but execution can overlap.
- Completion order is not guaranteed; Task 3 may finish before Task 1.

This shines when:

- You have independent units of work that can safely run in parallel.
- You want to maximize throughput on multi-core devices.

Creating serial and concurrent queues explicitly:

```swift
// Serial queue (default)
let serialQueue = DispatchQueue(label: "com.example.serial")

// Concurrent queue
let concurrentQueue = DispatchQueue(
  label: "com.example.concurrent",
  attributes: .concurrent
)

serialQueue.async {
  // Only one task at a time executes on this queue.
}

concurrentQueue.async {
  // Can overlap with other tasks scheduled on the same concurrent queue.
}
```

On iOS you typically use:

- The **main queue** (serial) for UI work.
- **Global concurrent queues** for CPU-bound or background work.
- **Custom serial or concurrent queues** for subsystem isolation (for example, a networking client
  or cache).

---

## 6. Summary: Bringing it All Together

Concurrency fundamentals boil down to two decisions for each piece of work:

1. **Manner of execution – sync vs async (caller)**
   - `sync`: the caller waits for the work to finish.
   - `async`: the caller continues immediately; the work runs later on the target queue.
2. **Order of execution – serial vs concurrent (queue)**
   - Serial queue: runs one task at a time in order.
   - Concurrent queue: starts multiple tasks that may overlap in execution.

Getting these choices right is essential for:

- Keeping your UI responsive (no blocking work on the main thread).
- Avoiding data races and subtle crashes.
- Making good use of available cores without overcomplicating your design.

Once this mental model is solid, you are in a strong position to:

- Understand higher-level Swift Concurrency features (`async`/`await`, actors, Task groups).
- Discuss more advanced Dispatch tools such as groups, barriers, and semaphores
  (<doc:concurrency-dispatch-design>).

That combination—strong fundamentals plus tool-specific knowledge—is what interviewers look for
when they ask about concurrency on iOS.
