//
// Advent of Code 2016 Day 12 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a
"""

@Suite("Day 12 Tests") 
struct Day12Tests {
    @Test("Day 12 Part 1", .tags(.testInput))
    func testDay12_part1() async {
        let day = Day12(input: testInput)
        await #expect(day.part1() == 42)
    }

    @Test("Day 12 Part 1 Solution")
    func testDay12_part1_solution() async {
        let day = Day12(input: Day12.input)
        await #expect(day.part1() == 318003)
    }

    @Test("Day 12 Part 2 Solution")
    func testDay12_part2_solution() async {
        let day = Day12(input: Day12.input)
        await #expect(day.part2() == 9227657)
    }
}
