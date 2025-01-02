//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/13
//
import AoCTools

final class Day13: AdventOfCodeDay {
    let title = "A Maze of Twisty Little Cubicles"

    class Floorplan {
        private let favoriteNumber: Int
        private var maxX = 0
        private var maxY = 0

        init(favoriteNumber: Int) {
            self.favoriteNumber = favoriteNumber
        }

        subscript(_ index: Point) -> Bool {
            maxX = max(maxX, index.x)
            maxY = max(maxY, index.y)
            return isWall(index)
        }

        private func isWall(_ point: Point) -> Bool {
            return !designerNumber(for: point, favoriteNumber).isMultiple(of: 2)
        }

        private func designerNumber(for point: Point, _ favoriteNumber: Int) -> Int {
            // x*x + 3*x + 2*x*y + y + y*y.
            var n = (point.x + 3) * point.x + 2 * point.x * point.y + (point.y + 1) * point.y + favoriteNumber
            var bits = 0
            while n > 0 {
                bits += n & 1
                n >>= 1
            }
            return bits
        }

        func show(_ markers: Set<Point>) {
            for y in 0...maxY {
                for x in 0...maxX {
                    let p = Point(x, y)
                    let ch = markers.contains(p) ? "o" : isWall(p) ? "#" : " "
                    print(ch, terminator: "")
                }
                print()
            }
            print()
        }

        func floodfill(from point: Point, maxSteps: Int) -> Set<Point> {
            var visited = Set<Point>()
            floodfill(from: point, maxSteps: maxSteps, &visited)
            return visited
        }

        private func floodfill(from point: Point, maxSteps: Int, _ visited: inout Set<Point>) {
            if visited.contains(point) {
                return
            }
            let pathfinder = AStarPathfinder(map: self)
            if pathfinder.shortestPath(from: Point(1, 1), to: point).count > maxSteps {
                return
            }

            visited.insert(point)
            for n in neighbors(of: point) {
                floodfill(from: n, maxSteps: maxSteps, &visited)
            }
        }
    }

    let input: Int

    init(input: String) {
        self.input = Int(input)!
    }

    func part1() async -> Int {
        await part1(target: Point(31, 39))
    }

    func part1(target: Point) async -> Int {
        let floorplan = Floorplan(favoriteNumber: input)
        let pathfinder = AStarPathfinder(map: floorplan)
        let path = pathfinder.shortestPath(from: Point(1, 1), to: target)
        // floorplan.show(Set(path))

        return path.count
    }

    func part2() async -> Int {
        let floorplan = Floorplan(favoriteNumber: input)
        let visited = floorplan.floodfill(from: Point(1, 1), maxSteps: 50)
        // floorplan.show(visited)

        return visited.count
    }
}

extension Day13.Floorplan: Pathfinding {
    func neighbors(of point: Point) -> [Point] {
        return point.neighbors().filter { p in
            p.x >= 0 && p.y >= 0 && self[p] == false
        }
    }

    func costToMove(from: Point, to: Point) -> Int {
        1
    }

    func distance(from: Point, to: Point) -> Int {
        abs(to.x - from.x) + abs(to.y - from.y)
    }
}
