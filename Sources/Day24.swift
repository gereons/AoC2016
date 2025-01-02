//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/24
//
import AoCTools

final class Day24: AdventOfCodeDay {
    let title = "Air Duct Spelunking"

    struct Point2: Hashable {
        let p1, p2: Point
    }

    final class Grid: Pathfinding {
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

        func neighbors(of point: Point) -> [Point] {
            point.neighbors().filter { points[$0] == true }
        }

        private var lengthCache = [Point2: Int]()

        func pathLength(from: Point, to: Point) -> Int {
            if let len = lengthCache[Point2(p1: from, p2: to)] {
                return len
            }

            let pathfinder = AStarPathfinder(map: self)
            let path = pathfinder.shortestPath(from: from, to: to)
            let len = path.count
            lengthCache[Point2(p1: from, p2: to)] = len
            return len
        }
    }

    let grid: Grid

    init(input: String) {
        grid = Grid(input.lines)
    }

    func part1() async -> Int {
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

    func part2() async -> Int {
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
