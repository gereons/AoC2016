//
// Advent of Code 2016 Day 15 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
Disc #1 has 5 positions; at time=0, it is at position 4.
Disc #2 has 2 positions; at time=0, it is at position 1.
"""

@Suite("Day 15 Tests") 
struct Day15Tests {
    @Test("Day 15 Part 1", .tags(.testInput))
    func testDay15_part1() async {
        let day = Day15(input: testInput)
        await #expect(day.part1() == 5)
    }

    @Test("Day 15 Part 1 Solution")
    func testDay15_part1_solution() async {
        let day = Day15(input: Day15.input)
        await #expect(day.part1() == 16824)
    }

    @Test("Day 15 Part 2", .tags(.testInput))
    func testDay15_part2() async {
        let day = Day15(input: testInput)
        await #expect(day.part2() == 85)
    }

    @Test("Day 15 Part 2 Solution")
    func testDay15_part2_solution() async {
        let day = Day15(input: Day15.input)
        await #expect(day.part2() == 3543984)
    }
}
