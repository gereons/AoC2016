//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/3
//

final class Day02: Day {
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

    let testData = [
        "ULL",
        "RRDDD",
        "LURDL",
        "UUUUD"
    ]

    func run() {
        // let data = testData
        let data = Self.data.components(separatedBy: "\n")

        print("Solution for part 1: \(part1(data))")
        print("Solution for part 2: \(part2(data))")
    }

    private func part1(_ data: [String]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        let keypad = [
            [ 1, 2, 3 ],
            [ 4, 5, 6 ],
            [ 7, 8, 9 ]
        ]

        // start on 5
        var x = 1
        var y = 1

        var code = 0
        for line in data {
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

    private func part2(_ data: [String]) -> String {
        let timer = Timer(day); defer { timer.show() }

        let keypad = [
            [ " ", " ", "1", " ", " " ],
            [ " ", "2", "3", "4", " " ],
            [ "5", "6", "7", "8", "9" ],
            [ " ", "A", "B", "C", " " ],
            [ " ", " ", "D", " ", " " ],
        ]

        // start on 5
        var x = 0
        var y = 2

        var code = ""
        for line in data {
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
