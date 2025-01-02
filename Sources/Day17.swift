//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/17
//

import AoCTools
import CryptoKit

final class Day17: AdventOfCodeDay {
    let title = "Two Steps Forward"

    enum Direction: String, CaseIterable {
        case up = "U"
        case down = "D"
        case left = "L"
        case right = "R"

        var offset: Point {
            switch self {
            case .up: return Point(0, -1)
            case .down: return Point(0, 1)
            case .left: return Point(-1, 0)
            case .right: return Point(1, 0)
            }
        }
    }

    let input: String

    init(input: String) {
        self.input = input
    }

    func part1() async -> String {
        part1and2().0
    }

    func part2() async -> Int {
        part1and2().1.count
    }

    private func part1and2() -> (String, String) {
        var solutions = [String]()
        move(from: Point(0, 0), to: Point(3, 3), path: "", solutions: &solutions)

        solutions.sort { $0.count < $1.count }

        return (solutions[0], solutions.last!)
    }

    private func move(from start: Point, to target: Point, path: String, solutions: inout [String]) {
        if start == target {
            // print("at vault", path)
            solutions.append(path)
            return
        }

        let hash = md5("\(input)\(path)")

        let neighbors = openDoors(hash).compactMap { dir -> (Direction, Point)? in
            let neighbor = start + dir.offset
            return validRoom(neighbor) ? (dir, neighbor) : nil
        }
        if neighbors.isEmpty {
            // print("dead end", path)
            return
        }

        for (direction, neighbor) in neighbors {
            move(from: neighbor, to: target, path: path + direction.rawValue, solutions: &solutions)
        }
    }

    private func openDoors(_ str: String) -> [Direction] {
        var result = [Direction]()
        let chars = Array(str)
        let open: ClosedRange<Character> = "b"..."f"
        for (index, dir) in Direction.allCases.enumerated() {
            if open ~= chars[index] {
                result.append(dir)
            }
        }
        return result
    }

    private func validRoom(_ point: Point) -> Bool {
        0...3 ~= point.x && 0...3 ~= point.y
    }

    private func md5(_ str: String) -> String {
        let data = str.data(using: .utf8)!
        let md5 = Array(Insecure.MD5.hash(data: data))
        return md5.map { String(format: "%02hhx", $0) }.joined()
    }
}
