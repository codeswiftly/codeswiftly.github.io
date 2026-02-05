# LeetCode 127: Word Ladder




Find the shortest transformation sequence from `beginWord` to `endWord` using one-letter changes.


Solve Hard problem.

Find the shortest transformation sequence from `beginWord` to `endWord` using one-letter changes.

## Core Ideas

- BFS for shortest path in an unweighted graph.
- Build adjacency via wildcard patterns (e.g., h*t, *it).

## Constraints and Complexity

- `wordList.length <= 5000`.
- Time `O(n * L^2)` with pattern indexing, space `O(n * L)`.

## Edge Cases

- `endWord` not in list.
- Duplicate words.

## Swift Starter

```swift
class Solution {
  func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
    // TODO: BFS with pattern map.
    return 0
  }
}
```

## Swift Solution (Commented)

```swift
class Solution {
  func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
    if !wordList.contains(endWord) { return 0 }

    let wordLength = beginWord.count
    var allWords = wordList
    if !allWords.contains(beginWord) { allWords.append(beginWord) }

    var patternMap: [String: [String]] = [:]
    for word in allWords {
      let chars = Array(word)
      for i in 0..<wordLength {
        var pattern = chars
        pattern[i] = "*"
        let key = String(pattern)
        patternMap[key, default: []].append(word)
      }
    }

    var queue: [(String, Int)] = [(beginWord, 1)]
    var visited: Set<String> = [beginWord]
    var index = 0

    while index < queue.count {
      let (word, level) = queue[index]
      index += 1
      if word == endWord { return level }

      let chars = Array(word)
      for i in 0..<wordLength {
        var pattern = chars
        pattern[i] = "*"
        let key = String(pattern)
        if let neighbors = patternMap[key] {
          for next in neighbors where !visited.contains(next) {
            visited.insert(next)
            queue.append((next, level + 1))
          }
          patternMap[key] = []
        }
      }
    }

    return 0
  }
}
```

## Interview Framing

- Bidirectional BFS can cut work in half.
- Clearing pattern buckets avoids repeated scans.
