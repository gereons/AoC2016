//
// Advent of Code 2016 Day 20 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
5-8
0-2
4-7
"""

@Suite("Day 20 Tests") 
struct Day20Tests {
    @Test("Day 20 Part 1", .tags(.testInput))
    func testDay20_part1() async {
        let day = Day20(input: testInput)
        await #expect(day.part1() == 3)
    }

    @Test("Day 20 Part 1 Solution")
    func testDay20_part1_solution() async {
        let day = Day20(input: Day20.input)
        await #expect(day.part1() == 32259706)
    }

    @Test("Day 20 Part 2", .tags(.testInput))
    func testDay20_part2() async {
        let day = Day20(input: testInput)
        await #expect(day.part2() == 1)
    }

    @Test("Day 20 Part 2 Solution")
    func testDay20_part2_solution() async {
        let day = Day20(input: Day20.input)
        await #expect(day.part2() == 113)
    }
}
