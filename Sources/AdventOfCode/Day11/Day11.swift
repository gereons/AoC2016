//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/11
//

final class Day11: Day {

    struct Floor: Hashable, CustomStringConvertible {
        let generators: Set<String>
        let chips: Set<String>

        var ok: Bool {
            generators.isEmpty || chips.isSubset(of: generators)
        }

        var isEmpty: Bool {
            generators.isEmpty && chips.isEmpty
        }

        init(_ generators: Set<String>, _ chips: Set<String>) {
            self.generators = generators
            self.chips = chips
        }

        init(_ str: String) {
            let tokens = str.split(separator: " ")
            if tokens[4] == "nothing" {
                generators = []
                chips = []
            } else {
                // The first floor contains a thulium generator, a thulium-compatible microchip, a plutonium generator, and a strontium generator.
                var g = Set<String>()
                var c = Set<String>()
                for (index, token) in tokens.enumerated() {
                    if token.hasPrefix("generator") {
                        g.insert(String(tokens[index-1]))
                    }
                    if token.hasPrefix("microchip") {
                        c.insert(String(tokens[index-1].split(separator: "-")[0]))
                    }
                }

                generators = g
                chips = c
            }
        }

        func add(_ c1: Cargo, _ c2: Cargo?) -> Floor {
            var gen = self.generators
            var ch = self.chips
            switch c1 {
            case .generator(let g):
                gen.insert(g)
            case .chip(let c):
                ch.insert(c)
            }
            switch c2 {
            case .generator(let g):
                gen.insert(g)
            case .chip(let c):
                ch.insert(c)
            case .none: ()
            }
            return Floor(gen, ch)
        }

        func remove(_ c1: Cargo, _ c2: Cargo?) -> Floor {
            var gen = self.generators
            var ch = self.chips
            switch c1 {
            case .generator(let g): gen.remove(g)
            case .chip(let c): ch.remove(c)
            }
            switch c2 {
            case .generator(let g): gen.remove(g)
            case .chip(let c): ch.remove(c)
            case .none: ()
            }
            return Floor(gen, ch)
        }

        var description: String {
            "G: \(generators) - C: \(chips)"
        }
    }

    enum Cargo: CustomStringConvertible {
        case generator(String)
        case chip(String)

        var description: String {
            switch self {
            case .generator(let g): return "G:\(g)"
            case .chip(let c): return "C:\(c)"
            }
        }
    }

    struct Move: CustomStringConvertible {
        let from: Int
        let to: Int
        let c1: Cargo
        let c2: Cargo?

        init(from: Int, to: Int, _ c1: Cargo, _ c2: Cargo? = nil) {
            self.from = from
            self.to = to
            self.c1 = c1
            self.c2 = c2
        }

        var description: String {
            "\(from) -> \(to): \(c1) \(c2?.description ?? "-/-")"
        }
    }

    struct Building: Hashable, CustomStringConvertible {
        let elevator: Int
        let floors: [Floor]

        init(_ floors: [Floor], elevator: Int) {
            self.floors = floors
            self.elevator = elevator
        }

        var allValid: Bool {
            floors.allSatisfy { $0.ok }
        }

        func validMoves(startAt index: Int, allowContainerMoveDown: Bool = false) -> [Move] {
            var moves = [Move]()
            let floor = floors[index]

            for n in neighbors(index) {
                if n == 0 && floors[0].isEmpty {
                    continue
                }
                if index == 2 && n == 1 && floors[1].isEmpty && floors[0].isEmpty {
                    continue
                }

                var cargo = [Cargo]()
                cargo.append(contentsOf: floor.generators.map { .generator($0) })
                cargo.append(contentsOf: floor.chips.map { .chip($0) })
                if cargo.isEmpty {
                    continue
                }

                for c in allPairs(cargo) {
                    let to = floors[n].add(c.0, c.1)
                    let from = floor.remove(c.0, c.1)
                    if to.ok && from.ok {
                        moves.append(Move(from: index, to: n, c.0, c.1))
                    }
                }
            }

            if moves.firstIndex(where: { $0.to > $0.from && $0.c2 != nil }) != nil {
                // don't bother taking one item up if we can take 2
                moves.removeAll { $0.to > $0.from && $0.c2 == nil }
            }
            if moves.firstIndex(where: { $0.to < $0.from && $0.c2 == nil }) != nil {
                // don't bring 2 items down if we can bring only one
                moves.removeAll { $0.to < $0.from && $0.c2 != nil }
            }

            return moves
        }

        func perform(_ move: Move) -> Building {
            var floors = self.floors
            floors[move.to] = floors[move.to].add(move.c1, move.c2)
            floors[move.from] = floors[move.from].remove(move.c1, move.c2)
            let b = Building(floors, elevator: move.to)
            assert(b.allValid)
            return b
        }

        func neighbors(_ index: Int) -> [Int] {
            [index+1, index-1].filter { $0 >= 0 && $0 < 4 }
        }

        private func allPairs(_ array: [Cargo]) -> [(Cargo, Cargo?)] {
            if array.isEmpty {
                return []
            }
            if array.count == 1 {
                return [(array[0], nil)]
            }

            var result = [(Cargo, Cargo?)]()
            for i in 0..<array.count-1 {
                for j in i+1..<array.count {
                    result.append((array[i], array[j]))
                    result.append((array[i], nil))
                }
            }
            result.append((array.last!, nil))
            return result
        }

        func hScore() -> Int {
            var h = 3 - elevator
            for (index, floor) in floors.enumerated() {
                h += floor.generators.count * (3-index)
                h += floor.chips.count * (3-index)
            }
            return h
        }

        var description: String {
            var d = ""
            for (index, floor) in floors.enumerated().reversed() {
                if index == elevator {
                    d += "E "
                } else {
                    d += "  "
                }
                d += "\(index): \(floor)\n"
            }
            return d
        }
    }

    struct Grid: Pathfinding {
        func neighbors(for building: Building) -> [Building] {
            let n = building.validMoves(startAt: building.elevator).map {
                building.perform($0)
            }
//            print("building")
//            print(building)
//            if !n.isEmpty {
//                print("neighbors")
//                n.forEach { print($0) }
//            }

            return n
        }

        func costToMove(from: Building, to: Building) -> Int {
            1
        }

        func hScore(from: Building, to: Building) -> Int {
            let h = abs(to.hScore() - from.hScore())
            // print(h)
            return h
        }
    }

    let testData = [
        "The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.",
        "The second floor contains a hydrogen generator.",
        "The third floor contains a lithium generator.",
        "The fourth floor contains nothing relevant."
    ]

    var building = Building([], elevator: 0)

    func run() {
        // let data = testData
        let data = Day11.data.components(separatedBy: "\n")

        Timer.time(day) {
            building = Building(data.map { Floor($0) }, elevator: 0)
        }

        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    func part1() -> Int {
        let timer = Timer("11"); defer { timer.show() }

        return solve(building)
    }

    func part2() -> Int {
        let timer = Timer("11"); defer { timer.show() }

        var floors = building.floors
        var gen = floors[0].generators
        gen.formUnion(["elerium", "dilithium"])
        var ch = floors[0].chips
        ch.formUnion(["elerium", "dilithium"])
        floors[0] = Floor(gen, ch)

        let building = Building(floors, elevator: 0)
        return solve(building)
    }

    private func solve(_ building: Building) -> Int {
        let generators = building.floors.flatMap { $0.generators }
        let chips = building.floors.flatMap { $0.chips }

        let floors = [
            Floor(Set(generators), Set(chips)),
            Floor([], []),
            Floor([], []),
            Floor([], [])
        ]
        let target = Building(floors.reversed(), elevator: 3)

        let grid = Grid()
        let pathfinder = AStarPathfinder(grid: grid)
        let path = pathfinder.shortestPathFrom(building, to: target)

        return path.count - 1
    }
}
