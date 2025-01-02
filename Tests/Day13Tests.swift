//
// Advent of Code 2016 Day 13 Tests
//

import Testing
import AoCTools
@testable import AdventOfCode

fileprivate let testInput = """
10
"""

@Suite("Day 13 Tests") 
struct Day13Tests {
    @Test("Day 13 Part 1", .tags(.testInput))
    func testDay13_part1() async {
        let day = Day13(input: testInput)
        await #expect(day.part1(target: Point(7, 4)) == 11)
    }

    @Test("Day 13 Part 1 Solution")
    func testDay13_part1_solution() async {
        let day = Day13(input: Day13.input)
        await #expect(day.part1() == 82)
    }

    @Test("Day 13 Part 2", .tags(.testInput))
    func testDay13_part2() async {
        let day = Day13(input: testInput)
        await #expect(day.part2() == 151)
    }

    @Test("Day 13 Part 2 Solution")
    func testDay13_part2_solution() async {
        let day = Day13(input: Day13.input)
        await #expect(day.part2() == 138)
    }
}
