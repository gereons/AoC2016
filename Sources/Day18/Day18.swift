//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/18
//

final class Day18: Day {
    let testInput = ".^^.^.^^^^"

    var trapped = [Bool]()

    func run() {
        Timer.time(day) {
            trapped = Self.data.map { $0 == "^" }
        }

        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }
        return traps(40)
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }
        return traps(400000)
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
        let l = index > 0 ? trapped[index-1] : false
        let c = trapped[index]
        let r = index < trapped.count-1 ? trapped[index+1] : false

        if l && c && !r { return true }
        if c && r && !l { return true }
        if l && !c && !r { return true }
        if r && !c && !l { return true }
        return false
    }
}
