//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/18
//
import AoCTools

final class Day18: AdventOfCodeDay {
    let title = "Like a Rogue"

    var trapped = [Bool]()

    init(input: String) {
        trapped = input.map { $0 == "^" }
    }

    func part1() async -> Int {
        await part1(rows: 40)
    }

    func part1(rows: Int) async -> Int {
        traps(rows)
    }

    func part2() async -> Int {
        traps(400000)
    }

    private func traps(_ loops: Int) -> Int {
        var prev = trapped
        var safe = prev.reduce(0) { $0 + (!$1 ? 1 : 0) }
        for _ in 1..<loops {
            var next = [Bool](repeating: false, count: prev.count)
            for index in 0..<prev.count {
                next[index] = rlc(prev, index)
            }
            // show(next)
            safe += next.reduce(0) { $0 + (!$1 ? 1 : 0) }
            prev = next
        }

        return safe
    }

    private func show(_ arr: [Bool]) {
        print(arr.map { $0 ? "^" : "." }.joined())
    }

    private func rlc(_ trapped: [Bool], _ index: Int) -> Bool {
        let l = index > 0 ? trapped[index - 1] : false
        let c = trapped[index]
        let r = index < trapped.count - 1 ? trapped[index + 1] : false

        if l && c && !r { return true }
        if c && r && !l { return true }
        if l && !c && !r { return true }
        if r && !c && !l { return true }
        return false
    }
}
