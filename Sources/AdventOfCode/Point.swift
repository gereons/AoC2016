//
//  Point.swift
//
//  Advent of Code 2016
//

struct Point: Hashable {
    let x, y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func add(_ point: Point) -> Point {
        Point(self.x + point.x, self.y + point.y)
    }

    static func +(_ lhs: Point, _ rhs: Point) -> Point {
        lhs.add(rhs)
    }

    func distance(from: Point, to: Point) -> Int {
        abs(to.x - from.x) + abs(to.y - from.y)
    }
}

extension Point {
    enum Adjacency {
        case orthogonal, diagonal, all
    }

    func neighbors(adjacency: Adjacency = .orthogonal) -> [Point] {
        let orthogonal = [ Point(0, -1), Point(-1, 0), Point(1, 0), Point(0, 1) ]
        let diagonal = [ Point(1, 1), Point(-1, -1), Point(1, -1), Point(-1, 1) ]

        let offsets: [Point]
        switch adjacency {
        case .orthogonal: offsets = orthogonal
        case .diagonal: offsets = diagonal
        case .all: offsets = orthogonal + diagonal
        }

        return offsets.map { add($0) }
    }
}

extension Point: CustomStringConvertible {
    var description: String {
        "\(x),\(y)"
    }
}
