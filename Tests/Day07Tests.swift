//
// Advent of Code 2016 Day 7 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
abba[mnop]qrst
abcd[bddb]xyyx
aaaa[qwer]tyui
ioxxoj[asdfgh]zxcvbn
"""

fileprivate let testInput2 = """
aba[bab]xyz
xyx[xyx]xyx
aaa[kek]eke
zazbz[bzb]cdb
"""

@Suite("Day 7 Tests") 
struct Day07Tests {
    @Test("Day 7 Part 1", .tags(.testInput))
    func testDay07_part1() async {
        let day = Day07(input: testInput)
        await #expect(day.part1() == 2)
    }

    @Test("Day 7 Part 1 Solution")
    func testDay07_part1_solution() async {
        let day = Day07(input: Day07.input)
        await #expect(day.part1() == 105)
    }

    @Test("Day 7 Part 2", .tags(.testInput))
    func testDay07_part2() async {
        let day = Day07(input: testInput2)
        await #expect(day.part2() == 3)
    }

    @Test("Day 7 Part 2 Solution")
    func testDay07_part2_solution() async {
        let day = Day07(input: Day07.input)
        await #expect(day.part2() == 258)
    }
}
