//
// Advent of Code 2016 Day 3 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
101 301 501
102 302 502
103 303 503
201 401 601
202 402 602
203 403 603
"""

@Suite("Day 3 Tests") 
struct Day03Tests {
    @Test("Day 3 Part 1 Solution")
    func testDay03_part1_solution() async {
        let day = Day03(input: Day03.input)
        await #expect(day.part1() == 869)
    }

    @Test("Day 3 Part 2", .tags(.testInput))
    func testDay03_part2() async {
        let day = Day03(input: testInput)
        await #expect(day.part2() == 6)
    }

    @Test("Day 3 Part 2 Solution")
    func testDay03_part2_solution() async {
        let day = Day03(input: Day03.input)
        await #expect(day.part2() == 1544)
    }
}
