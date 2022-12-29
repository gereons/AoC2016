//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/15
//

final class Day15: Day {
    struct Disc {
        let size: Int
        let start: Int

        init(_ str: String) {
            let tokens = str.split(separator: " ")
            size = Int(tokens[3])!
            start = Int(tokens[11].dropLast())!
        }
    }

    let testData = [
        "Disc #1 has 5 positions; at time=0, it is at position 4.",
        "Disc #2 has 2 positions; at time=0, it is at position 1."
    ]

    var discs = [Disc]()

    func run() {
        // let data = testData
        let data = Self.data.components(separatedBy: "\n")

        Timer.time(day) {
            discs = data.map { Disc($0) }
        }

        print("Solution for part 1: \(part1())")

        discs.append(Disc("Disc #X has 11 positions; at time=0, it is at position 0."))
        print("Solution for part 2: \(part1())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        return findTime()
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }

        return findTime()
    }

    private func findTime() -> Int {
        for time in 0...Int.max {
            var bounced = false
            for (index, disc) in discs.enumerated() {
                if (disc.start + time + index + 1) % disc.size != 0 {
                    bounced = true
                    break
                }
            }
            if !bounced {
                return time
            }
        }

        fatalError()
    }
}
