//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/22
//

final class Day22: Day {
    class Node: Equatable {
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

        static func ==(_ lhs: Node, _ rhs: Node) -> Bool {
            return lhs.point == rhs.point
        }
    }

    let testData = [
        "Filesystem            Size  Used  Avail  Use%",
        "/dev/grid/node-x0-y0   10T    8T     2T   80%",
        "/dev/grid/node-x0-y1   11T    6T     5T   54%",
        "/dev/grid/node-x0-y2   32T   28T     4T   87%",
        "/dev/grid/node-x1-y0    9T    7T     2T   77%",
        "/dev/grid/node-x1-y1    8T    0T     8T    0%",
        "/dev/grid/node-x1-y2   11T    7T     4T   63%",
        "/dev/grid/node-x2-y0   10T    6T     4T   60%",
        "/dev/grid/node-x2-y1    9T    8T     1T   88%",
        "/dev/grid/node-x2-y2    9T    6T     3T   66%"
    ]

    class Grid: Pathfinding {
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
        typealias Coordinate = Point
        func neighbors(for point: Point) -> [Point] {
            point.neighbors().filter {
                $0.x >= 0 && $0.y >= 0 && $0.x <= maxX && $0.y <= maxY && !invalids.contains($0)
            }
        }

        func costToMove(from: Point, to: Point) -> Int {
            1
        }

        func hScore(from: Point, to: Point) -> Int {
            from.distance(to: to)
        }
    }

    var nodes = [Node]()
    var grid = Grid([])

    func run() {
        // let data = testData
        let data = Self.data.components(separatedBy: "\n")

        Timer.time(day) {
            nodes = data.dropFirst(2).map { Node($0) }
            grid = Grid(nodes)
        }

        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

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

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }

        // find the path for the empty disc to the space next to our real goal (maxX-1,0)
        let goal = Point(grid.maxX-1, 0)
        let free = grid.nodes.values.first { $0.used == 0 }!

        let pathfinder = AStarPathfinder(grid: grid)
        let path = pathfinder.shortestPathFrom(free.point, to: goal)

        let initialSteps = path.count - 1

        // move goal data from (maxX,0) to (0,0), with the free disc always to the left
        // each step takes 5 moves, plus one last step to move from (1,0) to (0,0)
        let moveSteps = (grid.maxX - 1) * 5 + 1
        return initialSteps + moveSteps
    }
}
