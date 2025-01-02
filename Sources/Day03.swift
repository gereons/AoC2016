//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/3
//
import AoCTools

final class Day03: AdventOfCodeDay {
    let title = "Squares With Three Sides"

    var triangles = [[Int]]()

    init(input: String) {
        triangles = input.lines.map { line in
            let tokens = line.split(separator: " ")
            return [ Int(tokens[0])!, Int(tokens[1])!, Int(tokens[2])! ]
        }
    }

    func part1() async -> Int {
         triangles.filter { valid($0) }.count
    }

    private func valid(_ t: [Int]) -> Bool {
        t[0] + t[1] > t[2] &&
        t[0] + t[2] > t[1] &&
        t[1] + t[2] > t[0]
    }

    func part2() async -> Int {
        var count = 0
        for i in stride(from: 0, through: triangles.count - 1, by: 3) {
            if valid(column(0, at: i)) { count += 1 }
            if valid(column(1, at: i)) { count += 1 }
            if valid(column(2, at: i)) { count += 1 }
        }
        return count
    }

    private func column(_ col: Int, at row: Int) -> [Int] {
        [ triangles[row][col], triangles[row + 1][col], triangles[row + 2][col] ]
    }
}
