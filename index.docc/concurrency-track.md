# Concurrency and Queues


@Metadata {
  @PageColor(blue)
  @TitleHeading("Train concurrency instincts")
  @CallToAction(url: "doc:concurrency-beginners-guide", label: "Start with the basics")
}

@Options {
  @TopicsVisualStyle(detailedGrid)
  @AutomaticSeeAlso(disabled)
}


Mental models, GCD design, and concurrency drills that hold up in interviews.

@Row {
  @Column {
    **Intent**
    Narrate why each queue, group, or task exists.
  }
  @Column {
    **Risk**
    Call out race conditions and where you synchronize.
  }
  @Column {
    **Impact**
    Tie every choice to latency and user experience.
  }
}

## Start Here

@Links(visualStyle: detailedGrid) {

- <doc:concurrency-beginners-guide>
- <doc:concurrency-dispatch-design>
- <doc:concurrency-gcd-deep-dive>
}

## Track Map

@Row {
  @Column {
    **Foundation**
  }
  @Column {
    **GCD design**
  }
  @Column {
    **Deep dive**
  }
}

@Row {
  @Column {
    **Drill**
    [Concurrency Quiz Series](/tutorials/swift-interview-guide/concurrency-quiz)
  }
}

## Interview Traps

- Overusing global queues when isolation is required.
- Forgetting to protect mutable state or shared caches.
- Ignoring QoS or main-thread constraints for UI updates.
