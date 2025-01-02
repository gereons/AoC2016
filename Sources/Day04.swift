//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/4
//
import AoCTools

final class Day04: AdventOfCodeDay {
    let title = "Security Through Obscurity"

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

    let rooms: [Room]

    init(input: String) {
        rooms = input.lines.map { Room($0) }
    }

    func part1() async -> Int {
        let rooms = rooms.filter { $0.valid }
        return rooms.reduce(0) { $0 + $1.sectorId }
    }

    func part2() async -> Int {
        for room in rooms {
            if room.decrypted.hasPrefix("north") {
                return room.sectorId
            }
        }

        return 0
    }
}
