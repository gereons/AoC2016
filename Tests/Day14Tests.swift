//
// Advent of Code 2016 Day 14 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
abc
"""

@Suite("Day 14 Tests") 
struct Day14Tests {
    @Test("Day 14 Part 1", .tags(.testInput))
    func testDay14_part1() async {
        let day = Day14(input: testInput)
        await #expect(day.part1() == 22728)
    }

    @Test("Day 14 Part 1 Solution")
    func testDay14_part1_solution() async {
        let day = Day14(input: Day14.input)
        await #expect(day.part1() == 18626)
    }

    @Test("Day 14 Part 2", .tags(.testInput))
    func testDay14_part2() async {
        let day = Day14(input: testInput)
        await #expect(day.part2() == 22551)
    }

    @Test("Day 14 Part 2 Solution")
    func testDay14_part2_solution() async {
        let day = Day14(input: Day14.input)
        await #expect(day.part2() == 20092)
    }
}
