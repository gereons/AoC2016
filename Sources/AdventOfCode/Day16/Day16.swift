//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/16
//

final class Day16: Day {
    func run() {
        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> String {
        let timer = Timer(day); defer { timer.show() }

        return patternChecksum(272)
    }

    private func part2() -> String {
        let timer = Timer(day); defer { timer.show() }

        return patternChecksum(35651584)
    }

    private func patternChecksum(_ length: Int) -> String {
        var input = Self.data.map { $0 == "1" }

        while input.count < length {
            input = grow(input)
        }

        let chksum = checksum(Array(input.prefix(length)))
        return chksum.map { $0 ? "1" : "0" }.joined()
    }

    private func grow(_ input: [Bool]) -> [Bool] {
        var b = [Bool]()
        for ch in input.reversed() {
            b.append(!ch)
        }
        return input + [false] + b
    }

    private func checksum(_ array: [Bool]) -> [Bool] {
        var chk = [Bool](repeating: false, count: array.count / 2)
        for (i0, i1) in stride(from: 0, through: array.count-1, by: 2).enumerated() {
            chk[i0] = (array[i1] == array[i1+1])
        }
        assert(chk.count == array.count / 2)
        if chk.count.isMultiple(of: 2) {
            return checksum(chk)
        } else {
            return chk
        }
    }
}
