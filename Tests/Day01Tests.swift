//
// Advent of Code 2016 Day 1 Tests
//

import Testing
@testable import AdventOfCode

@Suite("Day 1 Tests") 
struct Day01Tests {
    @Test("Day 1 Part 1", .tags(.testInput))
    func testDay01_part1() async {
        let day = Day01(input: "R5, L5, R5, R3")
        await #expect(day.part1() == 12)
    }

    @Test("Day 1 Part 1 Solution")
    func testDay01_part1_solution() async {
        let day = Day01(input: Day01.input)
        await #expect(day.part1() == 300)
    }

    @Test("Day 1 Part 2", .tags(.testInput))
    func testDay01_part2() async {
        let day = Day01(input: "R8, R4, R4, R8")
        await #expect(day.part2() == 4)
    }

    @Test("Day 1 Part 2 Solution")
    func testDay01_part2_solution() async {
        let day = Day01(input: Day01.input)
        await #expect(day.part2() == 159)
    }
}
