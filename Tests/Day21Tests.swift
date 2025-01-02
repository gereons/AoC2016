//
// Advent of Code 2016 Day 21 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
swap position 4 with position 0
swap letter d with letter b
reverse positions 0 through 4
rotate left 1 step
move position 1 to position 4
move position 3 to position 0
rotate based on position of letter b
rotate based on position of letter d
"""

@Suite("Day 21 Tests") 
struct Day21Tests {
    @Test("Day 21 Part 1", .tags(.testInput))
    func testDay21_part1() async {
        let day = Day21(input: testInput)
        await #expect(day.part1(input: "abcde") == "decab")
    }

    @Test("Day 21 Part 1 Solution")
    func testDay21_part1_solution() async {
        let day = Day21(input: Day21.input)
        await #expect(day.part1() == "agcebfdh")
    }

    @Test("Day 21 Part 2 Solution")
    func testDay21_part2_solution() async {
        let day = Day21(input: Day21.input)
        await #expect(day.part2() == "afhdbegc")
    }
}
