//
// Advent of Code 2016 Day 19 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
5
"""

@Suite("Day 19 Tests") 
struct Day19Tests {
    @Test("Day 19 Part 1", .tags(.testInput))
    func testDay19_part1() async {
        let day = Day19(input: testInput)
        await #expect(day.part1() == 3)
    }

    @Test("Day 19 Part 1 Solution")
    func testDay19_part1_solution() async {
        let day = Day19(input: Day19.input)
        await #expect(day.part1() == 1808357)
    }

    @Test("Day 19 Part 2", .tags(.testInput))
    func testDay19_part2() async {
        let day = Day19(input: testInput)
        await #expect(day.part2() == 2)
    }

    @Test("Day 19 Part 2 Solution")
    func testDay19_part2_solution() async {
        let day = Day19(input: Day19.input)
        await #expect(day.part2() == 1407007)
    }
}
