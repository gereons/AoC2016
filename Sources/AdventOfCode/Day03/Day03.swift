//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/3
//

final class Day03: Day {
    let testData = [
        "  5  10  25"
    ]

    var triangles = [[Int]]()

    func run() {
        let data = Self.data.components(separatedBy: "\n")

        Timer.time(day) {
            triangles = data.map { line -> [Int] in
                let tokens = line.split(separator: " ")
                return [ Int(tokens[0])!, Int(tokens[1])!, Int(tokens[2])! ]
            }
        }

        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        return triangles.filter { valid($0) }.count
    }

    private func valid(_ t: [Int]) -> Bool {
        t[0] + t[1] > t[2] &&
        t[0] + t[2] > t[1] &&
        t[1] + t[2] > t[0]
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }

        var count = 0
        for i in stride(from: 0, through: triangles.count-1, by: 3) {
            if valid(column(0, at: i)) { count += 1 }
            if valid(column(1, at: i)) { count += 1 }
            if valid(column(2, at: i)) { count += 1 }
        }
        return count
    }

    private func column(_ col: Int, at row: Int) -> [Int] {
        [ triangles[row][col], triangles[row+1][col], triangles[row+2][col] ]
    }
}
