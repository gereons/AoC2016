//
// Advent of Code 2016 Day 17 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
ihgpwlah
"""

@Suite("Day 17 Tests") 
struct Day17Tests {
    @Test("Day 17 Part 1", .tags(.testInput))
    func testDay17_part1() async {
        let day = Day17(input: testInput)
        await #expect(day.part1() == "DDRRRD")
    }

    @Test("Day 17 Part 1 Solution")
    func testDay17_part1_solution() async {
        let day = Day17(input: Day17.input)
        await #expect(day.part1() == "DDRUDLRRRD")
    }

    @Test("Day 17 Part 2", .tags(.testInput))
    func testDay17_part2() async {
        let day = Day17(input: testInput)
        await #expect(day.part2() == 370)
    }

    @Test("Day 17 Part 2 Solution")
    func testDay17_part2_solution() async {
        let day = Day17(input: Day17.input)
        await #expect(day.part2() == 398)
    }
}
