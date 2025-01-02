//
// Advent of Code 2016 Day 4 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
aaaaa-bbb-z-y-x-123[abxyz]
a-b-c-d-e-f-g-h-987[abcde]
not-a-real-room-404[oarel]
totally-real-room-200[decoy]
"""

@Suite("Day 4 Tests") 
struct Day04Tests {
    @Test("Day 4 Part 1", .tags(.testInput))
    func testDay04_part1() async {
        let day = Day04(input: testInput)
        await #expect(day.part1() == 1514)
    }

    @Test("Day 4 Part 1 Solution")
    func testDay04_part1_solution() async {
        let day = Day04(input: Day04.input)
        await #expect(day.part1() == 158835)
    }

    @Test("Day 4 Part 2 Solution")
    func testDay04_part2_solution() async {
        let day = Day04(input: Day04.input)
        await #expect(day.part2() == 993)
    }
}
