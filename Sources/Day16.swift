//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/16
//
import AoCTools

final class Day16: AdventOfCodeDay {
    let title = "Dragon Checksum"

    let input: String

    init(input: String) {
        self.input = input
    }

    func part1(length: Int) async -> String {
        return patternChecksum(length)
    }

    func part1() async -> String {
        await part1(length: 272)
    }

    func part2() async -> String {
        await part1(length: 35651584)
    }

    private func patternChecksum(_ length: Int) -> String {
        var input = input.map { $0 == "1" }

        while input.count < length {
            input = grow(input)
        }

        let chksum = checksum(Array(input.prefix(length)))
        return chksum.map { $0 ? "1" : "0" }.joined()
    }

    private func grow(_ input: [Bool]) -> [Bool] {
        let b = input.reversed().map { !$0 }
        return input + [false] + b
    }

    private func checksum(_ array: [Bool]) -> [Bool] {
        var chk = [Bool](repeating: false, count: array.count / 2)
        for (i0, i1) in stride(from: 0, through: array.count - 1, by: 2).enumerated() {
            chk[i0] = (array[i1] == array[i1 + 1])
        }
        assert(chk.count == array.count / 2)
        if chk.count.isMultiple(of: 2) {
            return checksum(chk)
        } else {
            return chk
        }
    }
}
