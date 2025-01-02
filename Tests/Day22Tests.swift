//
// Advent of Code 2016 Day 22 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
root@ebhq-gridcenter# df -h
Filesystem            Size  Used  Avail  Use%
/dev/grid/node-x0-y0   10T    8T     2T   80%
/dev/grid/node-x0-y1   11T    6T     5T   54%
/dev/grid/node-x0-y2   32T   28T     4T   87%
/dev/grid/node-x1-y0    9T    7T     2T   77%
/dev/grid/node-x1-y1    8T    0T     8T    0%
/dev/grid/node-x1-y2   11T    7T     4T   63%
/dev/grid/node-x2-y0   10T    6T     4T   60%
/dev/grid/node-x2-y1    9T    8T     1T   88%
/dev/grid/node-x2-y2    9T    6T     3T   66%
"""

@Suite("Day 22 Tests") 
struct Day22Tests {
    @Test("Day 22 Part 1", .tags(.testInput))
    func testDay22_part1() async {
        let day = Day22(input: testInput)
        await #expect(day.part1() == 7)
    }

    @Test("Day 22 Part 1 Solution")
    func testDay22_part1_solution() async {
        let day = Day22(input: Day22.input)
        await #expect(day.part1() == 976)
    }

    @Test("Day 22 Part 2", .tags(.testInput))
    func testDay22_part2() async {
        let day = Day22(input: testInput)
        await #expect(day.part2() == 7)
    }

    @Test("Day 22 Part 2 Solution")
    func testDay22_part2_solution() async {
        let day = Day22(input: Day22.input)
        await #expect(day.part2() == 209)
    }
}
