//
// Advent of Code 2016 Day 8 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 8 Tests")
struct Day08Tests {
    @Test("Day 8 Part 1 Solution")
    func testDay08_part1_solution() async {
        let day = Day08(input: Day08.input)
        await #expect(day.part1() == 116)
    }

    @Test("Day 8 Part 2 Solution")
    func testDay08_part2_solution() async {
        let day = Day08(input: Day08.input)
        await #expect(day.part2() == "UPOJFLBCEZ")
    }
}
