import Foundation

for _ in 1...5 {
    Log.level(.info, "Hello, World!")
}

struct Log {
    enum Level: String { case info, error }

    static func level(_ level: Level, _ message: String, line: Int = #line) {
        print(level.rawValue + ":\(line) - \(message)")
    }
}

struct Tester {
    private(set) var passed = 0, failed = 0
    private var n = 1

    mutating func check<T: Equatable>(_ exp: T, got: T, _ label: String = "", line: Int = #line) {
        let result = exp == got
        if result {
            passed += 1
            Log.level(.info, "+++ Test #\(n)" + label, line: line)
        } else {
            failed += 1
            Log.level(.error, "xxx Test #\(n)" + label + ": exp: \(exp) got: \(got)", line: line)
        }
        n += 1
    }
}

var simpleTests = Tester()
simpleTests.check(false, got: true)
