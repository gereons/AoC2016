//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/3
//

import AoCTools

final class Day02: AdventOfCodeDay {
    let title = "Bathroom Security"

    enum Direction: String {
        case up = "U"
        case left = "L"
        case right = "R"
        case down = "D"

        var offset: (dx: Int, dy: Int) {
            switch self {
            case .up: return (0, -1)
            case .left: return (-1, 0)
            case .right: return (1, 0)
            case .down: return (0, 1)
            }
        }
    }

    let lines: [String]

    init(input: String) {
        lines = input.lines
    }

    func part1() async -> Int {
        let keypad = [
            [ 1, 2, 3 ],
            [ 4, 5, 6 ],
            [ 7, 8, 9 ]
        ]

        // start on 5
        var x = 1
        var y = 1

        var code = 0
        for line in lines {
            for ch in line {
                let dir = Direction(rawValue: String(ch))!
                let (dx, dy) = dir.offset
                x += dx
                y += dy
                x = max(0, min(x, 2))
                y = max(0, min(y, 2))
            }
            code *= 10
            code += keypad[y][x]
        }

        return code
    }

    func part2() async -> String {
        let keypad = [
            [ " ", " ", "1", " ", " " ],
            [ " ", "2", "3", "4", " " ],
            [ "5", "6", "7", "8", "9" ],
            [ " ", "A", "B", "C", " " ],
            [ " ", " ", "D", " ", " " ]
        ]

        // start on 5
        var x = 0
        var y = 2

        var code = ""
        for line in lines {
            for ch in line {
                let dir = Direction(rawValue: String(ch))!
                let (dx, dy) = dir.offset
                var nx = x + dx
                var ny = y + dy
                nx = max(0, min(nx, 4))
                ny = max(0, min(ny, 4))
                if keypad[ny][nx] != " " {
                    x = nx
                    y = ny
                }
            }
            code.append(keypad[y][x])
        }
        return code
    }
}
