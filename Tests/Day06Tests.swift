//
// Advent of Code 2016 Day 6 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar
"""

@Suite("Day 6 Tests") 
struct Day06Tests {
    @Test("Day 6 Part 1", .tags(.testInput))
    func testDay06_part1() async {
        let day = Day06(input: testInput)
        await #expect(day.part1() == "easter")
    }

    @Test("Day 6 Part 1 Solution")
    func testDay06_part1_solution() async {
        let day = Day06(input: Day06.input)
        await #expect(day.part1() == "tzstqsua")
    }

    @Test("Day 6 Part 2", .tags(.testInput))
    func testDay06_part2() async {
        let day = Day06(input: testInput)
        await #expect(day.part2() == "advent")
    }

    @Test("Day 6 Part 2 Solution")
    func testDay06_part2_solution() async {
        let day = Day06(input: Day06.input)
        await #expect(day.part2() == "myregdnr")
    }
}
