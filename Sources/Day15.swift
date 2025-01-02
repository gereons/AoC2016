//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/15
//
import AoCTools

final class Day15: AdventOfCodeDay {
    let title = "Timing is Everything"

    struct Disc {
        let size: Int
        let start: Int

        init(_ str: String) {
            let tokens = str.split(separator: " ")
            size = Int(tokens[3])!
            start = Int(tokens[11].dropLast())!
        }
    }

    let discs: [Disc]

    init(input: String) {
        discs = input.lines.map { Disc($0) }
    }

    func part1() async -> Int {
        return findTime(discs: discs)
    }

    func part2() async -> Int {
        var discs = self.discs
        discs.append(Disc("Disc #X has 11 positions; at time=0, it is at position 0."))

        return findTime(discs: discs)
    }

    private func findTime(discs: [Disc]) -> Int {
        for time in 0...Int.max {
            var bounced = false
            for (index, disc) in discs.enumerated() {
                if !(disc.start + time + index + 1).isMultiple(of: disc.size) {
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
