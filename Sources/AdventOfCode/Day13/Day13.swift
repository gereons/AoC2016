//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/13
//

final class Day13: Day {
    class Floorplan {
        let grid: [Point: Bool]
        let size: Int

        init(size: Int, favoriteNumber: Int) {
            var grid = [Point: Bool]()
            self.size = size

            for y in 0..<size {
                for x in 0..<size {
                    let point = Point(x, y)
                    let num = Self.designerNumber(for: point, favoriteNumber)
                    grid[point] = !num.isMultiple(of: 2)
                }
            }

            self.grid = grid
        }

        func show() {
            for y in 0..<size {
                for x in 0..<size {
                    let ch = grid[Point(x, y)] == true ? "#" : "."
                    print(ch, terminator: "")
                }
                print()
            }
            print()
        }

        private static func designerNumber(for point: Point, _ favoriteNumber: Int) -> Int {
            // x*x + 3*x + 2*x*y + y + y*y.
            var n =
                point.x * point.x +
                3 * point.x +
                2 * point.x * point.y +
                point.y +
                point.y * point.y +
                favoriteNumber
            print(n, String(n, radix: 2))
            var bits = 0
            while n > 0 {
                bits += n & 1
                n >>= 1
            }
            print(bits)
            return bits
        }
    }

    // let input = 10
    let input = 1362

    func run() {
        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        let office = Floorplan(size: 45, favoriteNumber: input)
        office.show()

        let pathfinder = AStarPathfinder(grid: office)
        let path = pathfinder.shortestPathFrom(Point(1,1), to: Point(31,39))

        return path.count - 1
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }
        return 0
    }
}

extension Day13.Floorplan: Pathfinding {
    typealias Coordinate = Point

    func neighbors(for point: Point) -> [Point] {
        let offsets = [ (0, -1), (-1, 0), (1, 0), (0, 1) ]

        var n = [Point]()
        for (dx, dy) in offsets {
            let np = Point(point.x + dx, point.y + dy)
            if np.x >= 0 && np.y >= 0 && grid[np] == false {
                n.append(np)
            }
        }
        return n
    }

    func costToMove(from: Point, to: Point) -> Int {
        1
    }

    func hScore(from: Point, to: Point) -> Int {
        return abs(to.x - from.x) + abs(to.y - from.y)
    }
}
