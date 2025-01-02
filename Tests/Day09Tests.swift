//
// Advent of Code 2016 Day 9 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 9 Tests")
struct Day09Tests {
    @Test("Day 9 Part 1 Solution")
    func testDay09_part1_solution() async {
        let day = Day09(input: Day09.input)
        await #expect(day.part1() == 107035)
    }

    @Test("Day 9 Part 2 Solution")
    func testDay09_part2_solution() async {
        let day = Day09(input: Day09.input)
        await #expect(day.part2() == 11451628995)
    }
}
