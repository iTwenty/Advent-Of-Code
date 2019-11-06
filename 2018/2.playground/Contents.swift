import PlaygroundSupport

struct CountingSet<K: Hashable>: CustomStringConvertible {
    private var dict: [K: Int] = [:]

    init<S: Sequence>(_ elements: S) where S.Element == K {
        for e in elements {
            self.add(e)
        }
    }

    mutating func add(_ key: K) {
        dict.updateValue((dict[key] ?? 0) + 1, forKey: key)
    }

    var description: String {
        dict.debugDescription
    }

    var keys: Set<K> {
        Set(dict.keys)
    }

    var values: Set<Int> {
        Set(dict.values)
    }
}

let path = playgroundSharedDataDirectory.appendingPathComponent("input")
let contents = try! String(contentsOf: path, encoding: .utf8)

var lines: [String] = []
var charFrequencies: [CountingSet<Character>] = []
contents.enumerateLines { (line, _) in
    lines.append(line)
    charFrequencies.append(CountingSet<Character>(line))
}

var twosCount = 0
var threesCount = 0

charFrequencies.forEach { (countingSet) in
    if countingSet.values.contains(2) {
        twosCount = twosCount + 1
    }
    if countingSet.values.contains(3) {
        threesCount = threesCount + 1
    }
}

// Part 1
print(twosCount * threesCount)

for i in 0..<lines.count - 1 {
    let fstLine = lines[i]
    for j in (i + 1)..<charFrequencies.count {
        let sndLine = lines[j]
        var differingCharIndices: [Int] = []
        for (idx, fstLineChar) in fstLine.enumerated() {
            let sndLineChar = sndLine[sndLine.index(sndLine.startIndex, offsetBy: idx)]
            if fstLineChar != sndLineChar {
                differingCharIndices.append(idx)
            }
        }
        if differingCharIndices.count == 1 {
            // Part 2: Swift syntax to exclude char from string is too long. So manually compare the two strings
            // and exclude common character to get the answer
            print("\(fstLine) \(sndLine)")
        }
    }
}
