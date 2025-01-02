//
// Advent of Code 2016 Day 2 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
ULL
RRDDD
LURDL
UUUUD
"""

@Suite("Day 2 Tests") 
struct Day02Tests {
    @Test("Day 2 Part 1", .tags(.testInput))
    func testDay02_part1() async {
        let day = Day02(input: testInput)
        await #expect(day.part1() == 1985)
    }

    @Test("Day 2 Part 1 Solution")
    func testDay02_part1_solution() async {
        let day = Day02(input: Day02.input)
        await #expect(day.part1() == 35749)
    }

    @Test("Day 2 Part 2", .tags(.testInput))
    func testDay02_part2() async {
        let day = Day02(input: testInput)
        await #expect(day.part2() == "5DB3")
    }

    @Test("Day 2 Part 2 Solution")
    func testDay02_part2_solution() async {
        let day = Day02(input: Day02.input)
        await #expect(day.part2() == "9365C")
    }
}
