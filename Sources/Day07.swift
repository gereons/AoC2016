//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/7
//
import AoCTools

final class Day07: AdventOfCodeDay {
    let title = "Internet Protocol Version 7"

    struct Address {
        let supernet: [String]
        let hypernet: [String]

        init(_ str: String) {
            // abba[mnop]qrst[aksd]lakjsd...
            var outside = [String]()
            var inside = [String]()

            let tokens = str.split(separator: "[")
            outside.append(String(tokens[0]))
            for token in tokens.dropFirst() {
                let t = token.split(separator: "]")
                inside.append(String(t[0]))
                outside.append(String(t[1]))
            }
            self.supernet = outside
            self.hypernet = inside
        }

        var supportsTLS: Bool {
            if hypernet.firstIndex(where: { hasAbba($0) }) != nil {
                return false
            }
            return supernet.firstIndex { hasAbba($0) } != nil
        }

        var supportsSSL: Bool {
            for aba in findABAs() {
                if hasBAB(aba) {
                    return true
                }
            }
            return false
        }

        private func hasAbba(_ str: String) -> Bool {
            let chars = Array(str)
            for i in 0..<chars.count - 3 {
                if chars[i + 1] == chars[i + 2] && chars[i + 3] == chars[i] && chars[i + 1] != chars[i] {
                    return true
                }
            }
            return false
        }

        private func findABAs() -> Set<String> {
            var abas = Set<String>()
            for s in supernet {
                let chars = Array(s)
                for i in 0..<chars.count - 2 {
                    if chars[i] == chars[i + 2] && chars[i + 1] != chars[i] {
                        let aba = String(chars[i...i + 2])
                        abas.insert(aba)
                    }
                }
            }
            return abas
        }

        private func hasBAB(_ aba: String) -> Bool {
            let bab = "\(aba[1])\(aba[0])\(aba[1])"
            for h in hypernet {
                if h.indexOf(bab) != nil {
                    return true
                }
            }
            return false
        }
    }

    var addresses = [Address]()

    init(input: String) {
        addresses = input.lines.map { Address($0) }
    }

    func part1() async -> Int {
        return addresses.count { $0.supportsTLS }
    }

    func part2() async -> Int {
        return addresses.count { $0.supportsSSL }
    }
}
