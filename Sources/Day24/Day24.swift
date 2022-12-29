//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/24
//

final class Day24: Day {
    class Grid: Pathfinding {
        let points: [Point: Bool] // value true==Floor, false==Wall
        let robots: [Int: Point]

        init(_ data: [String]) {
            var points = [Point: Bool]()
            var robots = [Int: Point]()

            for (y, line) in data.enumerated() {
                for (x, ch) in line.enumerated() {
                    let point = Point(x, y)
                    if ch == "#" {
                        points[point] = false
                    } else if ch == "." {
                        points[point] = true
                    } else if let id = Int(String(ch)) {
                        points[point] = true
                        robots[id] = point
                    }
                }
            }

            self.points = points
            self.robots = robots
        }

        func neighbors(for point: Point) -> [Point] {
            point.neighbors().filter { points[$0] == true }
        }

        func costToMove(from: Point, to: Point) -> Int {
            1
        }

        func hScore(from: Point, to: Point) -> Int {
            from.distance(to: to)
        }

        private struct Point2: Hashable {
            let p1, p2: Point
        }

        private var lengthCache = [Point2: Int]()

        func pathLength(from: Point, to: Point) -> Int {
            if let len = lengthCache[Point2(p1: from, p2: to)] {
                return len
            }

            let pathfinder = AStarPathfinder(grid: self)
            let path = pathfinder.shortestPathFrom(from, to: to)
            let len = path.count - 1
            lengthCache[Point2(p1: from, p2: to)] = len
            return len
        }
    }

    let testData = [
        "###########",
        "#0.1.....2#",
        "#.#######.#",
        "#4.......3#",
        "###########"
    ]

    var grid = Grid([])

    func run() {
        // let data = self.testData
        let data = Self.data.components(separatedBy: "\n")

        Timer.time(day) {
            grid = Grid(data)
        }

        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        var robots = grid.robots
        let start = robots[0]!
        robots[0] = nil

        var result = [[Int]]()
        findPathLengths(from: start, to: Set(robots.values), [], &result)

        let pathLengths = result.map { $0.reduce(0, +) }

        return pathLengths.min()!
    }

    private func findPathLengths(from start: Point, to targets: Set<Point>, _ stepsSoFar: [Int], _ result: inout [[Int]]) {
        if targets.isEmpty {
            result.append(stepsSoFar)
            return
        }

        for t in targets {
            var steps = stepsSoFar
            steps.append(grid.pathLength(from: start, to: t))
            var remainingTargets = targets
            remainingTargets.remove(t)
            findPathLengths(from: t, to: remainingTargets, steps, &result)
        }
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }

        var robots = grid.robots
        let start = robots[0]!
        robots[0] = nil

        var result = [[Int]]()
        findPathLengths2(from: start, to: Set(robots.values), [], &result)

        let pathLengths = result.map { $0.reduce(0, +) }

        return pathLengths.min()!
    }

    private func findPathLengths2(from start: Point, to targets: Set<Point>, _ stepsSoFar: [Int], _ result: inout [[Int]]) {
        if targets.isEmpty {
            let backToStart = grid.pathLength(from: start, to: grid.robots[0]!)
            result.append(stepsSoFar + [backToStart])
            return
        }

        for t in targets {
            var steps = stepsSoFar
            steps.append(grid.pathLength(from: start, to: t))
            var remainingTargets = targets
            remainingTargets.remove(t)
            findPathLengths2(from: t, to: remainingTargets, steps, &result)
        }
    }
}
