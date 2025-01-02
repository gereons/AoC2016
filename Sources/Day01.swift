//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/1
//

import AoCTools

final class Day01: AdventOfCodeDay {
    let title = "No Time for a Taxicab"

    enum Orientation {
        case north, east, south, west

        func turn(_ turn: Turn) -> Orientation {
            switch self {
            case .north: return turn == .left ? .west : .east
            case .east: return turn == .left ? .north : .south
            case .west: return turn == .left ? .south : .north
            case .south: return turn == .left ? .east : .west
            }
        }

        var offset: (dx: Int, dy: Int) {
            switch self {
            case .north: return (0, 1)
            case .east: return (1, 0)
            case .west: return (-1, 0)
            case .south: return (0, -1)
            }
        }
    }

    enum Turn {
        case left, right
    }

    struct Direction {
        let turn: Turn
        let distance: Int

        init(_ str: String) {
            let s = str.trimmed()
            distance = Int(s.dropFirst())!
            switch s.first {
            case "L": turn = .left
            case "R": turn = .right
            default: fatalError()
            }
        }
    }

    var directions = [Direction]()

    init(input: String) {
        directions = input.split(separator: ",").map { Direction(String($0)) }
    }

    func part1() async -> Int {
        var orientation = Orientation.north
        var x = 0
        var y = 0
        for dir in directions {
            orientation = orientation.turn(dir.turn)
            // print("turned to \(orientation)")
            let (dx, dy) = orientation.offset
            x += dx * dir.distance
            y += dy * dir.distance
            // print("new point \(x),\(y)")
        }

        let distance = abs(x) + abs(y)
        return distance
    }

    func part2() async -> Int {
        var visited = Set<Point>()
        var orientation = Orientation.north
        var x = 0
        var y = 0
        visited.insert(Point(x, y))
        for dir in directions {
            orientation = orientation.turn(dir.turn)
            // print("turned to \(orientation)")
            let (dx, dy) = orientation.offset
            for _ in 1 ... dir.distance {
                x += dx
                y += dy
                let p = Point(x, y)
                // print("moved to \(p)")
                if visited.contains(p) {
                    let distance = abs(x) + abs(y)
                    return distance
                } else {
                    visited.insert(p)
                }
            }
        }

        return 0
    }
}
