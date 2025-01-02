//
// Advent of Code 2016 Day 23 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
cpy 2 a
tgl a
tgl a
tgl a
cpy 1 a
dec a
dec a
"""

@Suite("Day 23 Tests") 
struct Day23Tests {
    @Test("Day 23 Part 1", .tags(.testInput))
    func testDay23_part1() async {
        let day = Day23(input: testInput)
        await #expect(day.part1() == 3)
    }

    @Test("Day 23 Part 1 Solution")
    func testDay23_part1_solution() async {
        let day = Day23(input: Day23.input)
        await #expect(day.part1() == 11415)
    }

    @Test("Day 23 Part 2", .tags(.testInput))
    func testDay23_part2() async {
        let day = Day23(input: testInput)
        await #expect(day.part2() == 3)
    }

    @Test("Day 23 Part 2 Solution")
    func testDay23_part2_solution() async {
        let day = Day23(input: Day23.input)
        await #expect(day.part2() == 479007975)
    }
}
