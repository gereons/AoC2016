//
// Advent of Code 2016 Day 5 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
abc
"""

@Suite("Day 5 Tests") 
struct Day05Tests {
    @Test("Day 5 Part 1", .tags(.testInput))
    func testDay05_part1() async {
        let day = Day05(input: testInput)
        await #expect(day.part1() == "18f47a30")
    }

    @Test("Day 5 Part 1 Solution")
    func testDay05_part1_solution() async {
        let day = Day05(input: Day05.input)
        await #expect(day.part1() == "801b56a7")
    }

    @Test("Day 5 Part 2", .tags(.testInput))
    func testDay05_part2() async {
        let day = Day05(input: testInput)
        await #expect(day.part2() == "05ace8e3")
    }

    @Test("Day 5 Part 2 Solution")
    func testDay05_part2_solution() async {
        let day = Day05(input: Day05.input)
        await #expect(day.part2() == "424a0197")
    }
}
