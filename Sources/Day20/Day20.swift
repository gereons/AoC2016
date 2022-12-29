//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/20
//

final class Day20: Day {
    let testData = [
        "5-8",
        "0-2",
        "4-7"
    ]

    var ranges = [ClosedRange<Int>]()

    func run() {
        // let data = testData
        let data = Self.data.components(separatedBy: "\n")

        Timer.time(day) {
            ranges = data.map { line -> ClosedRange<Int> in
                let tokens = line.split(separator: "-")
                return Int(tokens[0])!...Int(tokens[1])!
            }
            ranges.sort { $0.lowerBound < $1.lowerBound }
        }

        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        var check = 0
        for r in ranges {
            if r ~= check {
                check = r.upperBound + 1
            } else {
                if let upper = findUpper(check) {
                    check = upper + 1
                } else {
                    return check
                }
            }
        }

        return -1
    }

    private func findUpper(_ n: Int) -> Int? {
        for r in ranges.reversed() {
            if r ~= n {
                return r.upperBound
            }
        }
        return nil
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }

        var merged = ranges

        var skip = 0
        while true {
            var count = merged.count
            while true {
                merged = mergeOverlappingRanges(merged, skip)
                if merged.count == count {
                    break
                }
                count = merged.count
            }
            skip += 1
            if skip >= merged.count {
                break
            }
        }

        for i in 0..<merged.count - 1 {
            for j in i+1 ..< merged.count {
                assert(overlap(merged[i], merged[j]) == nil)
            }
        }

        var gaps = 0
        var prev: ClosedRange<Int>?
        for r in merged {
            if let p = prev {
                if r.lowerBound > p.upperBound + 1 {
                    let gap = r.lowerBound - p.upperBound - 1
                    gaps += gap
                }
            }
            prev = r
        }
        return gaps
    }

    func mergeOverlappingRanges(_ ranges: [ClosedRange<Int>], _ skip: Int) -> [ClosedRange<Int>] {
        var result = [ClosedRange<Int>]()

        result.append(contentsOf: ranges[0...skip])
        for range in ranges.dropFirst(skip+1) {
            if let overlap = overlap(result[skip], range) {
                result[skip] = overlap
            } else {
                result.append(range)
            }
        }

        return result
    }

    private func overlap(_ r1: ClosedRange<Int>, _ r2: ClosedRange<Int>) -> ClosedRange<Int>? {
        if (r1.upperBound >= r2.lowerBound && r1.upperBound <= r2.upperBound) ||
           (r2.upperBound >= r1.lowerBound && r2.upperBound <= r1.upperBound) ||
            (r1.lowerBound < r2.lowerBound && r1.upperBound > r2.upperBound) ||
            (r2.lowerBound < r1.lowerBound && r2.upperBound > r1.upperBound) {
            let low = min(r1.lowerBound, r2.lowerBound)
            let upper = max(r1.upperBound, r2.upperBound)
            return low...upper
        }
        return nil
    }
}
