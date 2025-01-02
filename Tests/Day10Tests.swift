//
// Advent of Code 2016 Day 10 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 10 Tests") 
struct Day10Tests {
    @Test("Day 10 Part 1 Solution")
    func testDay10_part1_solution() async {
        let day = Day10(input: Day10.input)
        await #expect(day.part1() == 161)
    }

    @Test("Day 10 Part 2 Solution")
    func testDay10_part2_solution() async {
        let day = Day10(input: Day10.input)
        await #expect(day.part2() == 133163)
    }
}
