//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/6
//
import AoCTools

final class Day06: AdventOfCodeDay {
    let title = "Signals and Noise"

    var chars = [[Character]]()

    init(input: String) {
        chars = input.lines.map { Array($0) }
    }

    func part1() async -> String {
        var decrypted = ""
        for i in 0 ..< chars[0].count {
            var charCount = [Character: Int]()
            for j in 0 ..< chars.count {
                charCount[chars[j][i], default: 0] += 1
            }
            let ch = charCount.sorted { $0.value > $1.value }.first?.key
            decrypted.append(ch!)
        }
        return decrypted
    }

    func part2() async -> String {
        var decrypted = ""
        for i in 0 ..< chars[0].count {
            var charCount = [Character: Int]()
            for j in 0 ..< chars.count {
                charCount[chars[j][i], default: 0] += 1
            }
            let ch = charCount.sorted { $0.value < $1.value }.first?.key
            decrypted.append(ch!)
        }
        return decrypted
    }
}
