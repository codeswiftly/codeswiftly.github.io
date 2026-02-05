# Pattern 12: Graph Breadth-First Search


@Metadata {
  @TitleHeading("Practice Graph Breadth-First Search")
}


Find the shortest path in an unweighted graph by visiting nodes in concentric circles outward from the start.

## Problem

- Fewest-step paths in an unweighted graph.

## Solution

- BFS with a queue and visited set per layer.

## Concept

Unlike Tree BFS, Graph BFS must handle cycles.

- **Queue**: Stores `(node, distance)`.
- **Visited Set**: Tracks visited nodes to prevent cycles and redundant processing.
- **Layers**: All nodes at distance `k` are processed before nodes at distance `k+1`.

## Complexity

- **Time**: O(V + E). Each vertex and edge is processed once.
- **Space**: O(V) for the queue and visited set.

## When to Use

- **Shortest Path**: Finding the minimum number of steps/edges.
- **Connected Components**: Finding all nodes reachable from a start node.
- **Level-based properties**: Nodes at distance K.

## Examples

### 1. Shortest Path in Unweighted Graph

```swift
func shortestPath(_ graph: [[Int]], _ start: Int, _ target: Int) -> Int {
  var queue = [(start, 0)]
  var visited = Set([start])

  while !queue.isEmpty {
    let (node, dist) = queue.removeFirst()

    if node == target { return dist }

    for neighbor in graph[node] where !visited.contains(neighbor) {
      visited.insert(neighbor)
      queue.append((neighbor, dist + 1))
    }
  }
  return -1
}
```

### 2. Word Ladder

Transform `beginWord` to `endWord` changing one letter at a time.

```swift
func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
  let words = Set(wordList)
  if !words.contains(endWord) { return 0 }

  var queue = [(beginWord, 1)]  // (word, steps)
  var visited = Set([beginWord])

  while !queue.isEmpty {
    let (currentWord, steps) = queue.removeFirst()
    if currentWord == endWord { return steps }

    let chars = Array(currentWord)
    for i in 0..<chars.count {
      var nextChars = chars
      for charCode in 97...122 {  // 'a'...'z'
        let char = Character(UnicodeScalar(charCode)!)
        if char == nextChars[i] { continue }
        nextChars[i] = char
        let nextWord = String(nextChars)

        if words.contains(nextWord) && !visited.contains(nextWord) {
          visited.insert(nextWord)
          queue.append((nextWord, steps + 1))
        }
      }
    }
  }
  return 0
}
```

## Common Pitfalls

- **Bidirectional BFS**: For large graphs, searching from both Start and End can meet in the middle faster (O(b^(d/2)) vs O(b^d)).
- **Level Size Loop**: Like Tree BFS, use an inner loop if you need to track "steps" without storing them in the tuple.

## Problems

@Links(visualStyle: detailedGrid) {

- <doc:leetcode-752-open-the-lock>
- <doc:leetcode-773-sliding-puzzle>
- <doc:leetcode-909-snakes-and-ladders>
}

## See Also

- <doc:top-15-patterns>
