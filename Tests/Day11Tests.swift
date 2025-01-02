//
// Advent of Code 2016 Day 11 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
The second floor contains a hydrogen generator.
The third floor contains a lithium generator.
The fourth floor contains nothing relevant.
"""

@Suite("Day 11 Tests") 
struct Day11Tests {
    @Test("Day 11 Part 1", .tags(.testInput))
    func testDay11_part1() async {
        let day = Day11(input: testInput)
        await #expect(day.part1() == 11)
    }

    @Test("Day 11 Part 1 Solution")
    func testDay11_part1_solution() async {
        let day = Day11(input: Day11.input)
        await #expect(day.part1() == 31)
    }

    @Test("Day 11 Part 2 Solution")
    func testDay11_part2_solution() async {
        let day = Day11(input: Day11.input)
        await #expect(day.part2() == 55)
    }
}
