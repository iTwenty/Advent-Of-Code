import Cocoa
import PlaygroundSupport

extension Array {
    public func cycle() -> UnfoldSequence<Element, Int> {
        return sequence(state: 0) { (index: inout Int) -> Element? in
            let x: Element = self[index]
            index = (index + 1) % self.count
            return x
        }
    }
}

let path = playgroundSharedDataDirectory.appendingPathComponent("input")
let contents = try! String(contentsOf: path, encoding: .utf8)
var fluctuations: [Int] = []
contents.enumerateLines { (line, stop) in
    if let value = Int(line) {
        fluctuations.append(value)
    }
}

let total = fluctuations.reduce(into: 0) { (result, fluctuation) in
    result = result + fluctuation
}

// Part 1
print(total)

var currentTotal = 0
var calculations: Set<Int> = [currentTotal]

for fluctuation in fluctuations.cycle() {
    currentTotal = currentTotal + fluctuation
    if calculations.contains(currentTotal) {
        // Part 2
        print(currentTotal)
        break
    }
    calculations.insert(currentTotal)
}
