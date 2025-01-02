//
// Advent of Code 2016 Day 16 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
10000
"""

@Suite("Day 16 Tests") 
struct Day16Tests {
    @Test("Day 16 Part 1", .tags(.testInput))
    func testDay16_part1() async {
        let day = Day16(input: testInput)
        await #expect(day.part1(length: 20) == "01100")
    }

    @Test("Day 16 Part 1 Solution")
    func testDay16_part1_solution() async {
        let day = Day16(input: Day16.input)
        await #expect(day.part1() == "10010010110011010")
    }

    @Test("Day 16 Part 2 Solution")
    func testDay16_part2_solution() async {
        let day = Day16(input: Day16.input)
        await #expect(day.part2() == "01010100101011100")
    }
}
