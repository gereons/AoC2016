//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/22
//
import AoCTools

final class Day22: AdventOfCodeDay {
    let title = "Grid Computing"

    final class Node: Equatable {
        let name: String
        let point: Point
        let size: Int
        let used: Int
        let avail: Int

        init(_ str: String) {
            // /dev/grid/node-x0-y1     88T   65T    23T   73%
            let tokens = str.split(separator: " ")
            name = String(tokens[0])
            let p = tokens[0].split(separator: "-")
            let x = Int(p[1].dropFirst())!
            let y = Int(p[2].dropFirst())!
            point = Point(x, y)
            size = Int(tokens[1].dropLast())!
            used = Int(tokens[2].dropLast())!
            avail = Int(tokens[3].dropLast())!
        }

        static func == (_ lhs: Node, _ rhs: Node) -> Bool {
            return lhs.point == rhs.point
        }
    }

    final class Grid: Pathfinding {
        private(set) var nodes = [Point: Node]()
        var invalids = Set<Point>()
        let maxX: Int
        let maxY: Int

        init(_ nodes: [Node]) {
            self.nodes.reserveCapacity(nodes.count)
            var maxX = 0
            var maxY = 0
            for n in nodes {
                self.nodes[n.point] = n
                maxX = max(maxX, n.point.x)
                maxY = max(maxY, n.point.y)
            }

            self.maxX = maxX
            self.maxY = maxY
        }

        // MARK: - pathfinding
        func neighbors(of point: Point) -> [Point] {
            point.neighbors().filter {
                $0.x >= 0 && $0.y >= 0 && $0.x <= maxX && $0.y <= maxY && !invalids.contains($0)
            }
        }
    }

    let nodes: [Node]
    let grid: Grid

    init(input: String) {
        nodes = input.lines.dropFirst(2).map { Node($0) }
        grid = Grid(nodes)
    }

    func part1() async -> Int {
        var valid = [Point: Point]()
        for a in nodes {
            for b in nodes {
                if a == b { continue }
                if a.used == 0 { continue }
                if b.avail >= a.used {
                    assert(valid[a.point] == nil)
                    valid[a.point] = b.point
                }
            }
        }

        grid.invalids = Set(grid.nodes.keys).subtracting(valid.keys).subtracting(Set(valid.values))

        return valid.count
    }

    func part2() async -> Int {
        _ = await part1()

        // find the path for the empty disc to the space next to our real goal (maxX-1,0)
        let goal = Point(grid.maxX - 1, 0)
        let free = grid.nodes.values.first { $0.used == 0 }!

        let pathfinder = AStarPathfinder(map: grid)
        let path = pathfinder.shortestPath(from: free.point, to: goal)

        let initialSteps = path.count

        // move goal data from (maxX,0) to (0,0), with the free disc always to the left
        // each step takes 5 moves, plus one last step to move from (1,0) to (0,0)
        let moveSteps = (grid.maxX - 1) * 5 + 1
        return initialSteps + moveSteps
    }
}
