//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/4
//

final class Day04: Day {
    struct Room {
        let name: String
        let sectorId: Int
        let checksum: String

        init(_ str: String) {
            // aaaaa-bbb-z-y-x-123[abxyz]
            var tokens = str.split(separator: "[")
            checksum = String(tokens[1].dropLast())
            tokens = tokens[0].split(separator: "-")
            sectorId = Int(tokens.last!)!
            name = tokens.dropLast().map { String($0) }.joined(separator: "-")
        }

        var valid: Bool {
            var chars = [Character: Int]()
            for ch in name {
                chars[ch, default: 0] += 1
            }
            chars["-"] = nil
            let top5 = chars.sorted {
                if $0.value == $1.value {
                    return $0.key < $1.key
                }
                return $0.value > $1.value
            }
                .prefix(5)
                .map { String($0.key) }
                .joined()

            return top5 == checksum
        }

        var decrypted: String {
            let distance = sectorId % 26
            var result = ""
            for ch in name {
                switch ch {
                case "-": result.append(" ")
                case "a"..."z": result.append(rot(ch, distance))
                default: fatalError()
                }
            }
            return result
        }

        private func rot(_ ch: Character, _ distance: Int) -> Character {
            var v = ch.asciiValue!
            v += UInt8(distance)
            if v > 122 {
                v -= 26
            }
            return Character(UnicodeScalar(v))
        }
    }

    let testData = [
        "aaaaa-bbb-z-y-x-123[abxyz]",
        "a-b-c-d-e-f-g-h-987[abcde]",
        "not-a-real-room-404[oarel]",
        "totally-real-room-200[decoy]",
    ]

    var rooms = [Room]()

    func run() {
        // let data = testData
        let data = Self.data.components(separatedBy: "\n")

        Timer.time(day) {
            rooms = data.map { Room($0) }
        }

        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        rooms = rooms.filter { $0.valid }
        return rooms.reduce(0) { $0 + $1.sectorId }
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }

        for room in rooms {
            if room.decrypted.hasPrefix("north") {
                return room.sectorId
            }
        }

        return 0
    }
}
