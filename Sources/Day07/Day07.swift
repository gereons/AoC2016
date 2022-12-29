//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/7
//

final class Day07: Day {
    let testData = [
        "abba[mnop]qrst",
        "abcd[bddb]xyyx",
        "aaaa[qwer]tyui",
        "ioxxoj[asdfgh]zxcvbn"
    ]

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
            let chars = str.map { $0 }
            for i in 0..<chars.count-3 {
                if chars[i+1] == chars[i+2] && chars[i+3] == chars[i] && chars[i+1] != chars[i] {
                    return true
                }
            }
            return false
        }

        private func findABAs() -> Set<String> {
            var abas = Set<String>()
            for s in supernet {
                let chars = s.map { $0 }
                for i in 0..<chars.count-2 {
                    if chars[i] == chars[i+2] && chars[i+1] != chars[i] {
                        let aba = String(chars[i...i+2])
                        abas.insert(aba)
                    }
                }
            }
            return abas
        }

        private func hasBAB(_ aba: String) -> Bool {
            let bab = aba.charAt(1) + aba.charAt(0) + aba.charAt(1)
            for h in hypernet {
                if h.indexOf(bab) != nil {
                    return true
                }
            }
            return false
        }
    }

    var addresses = [Address]()
    func run() {
        // let data = testData
        let data = Self.data.components(separatedBy: "\n")

        Timer.time(day) {
            // parse data here
            addresses = data.map { Address($0) }
        }

        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        return addresses.count { $0.supportsTLS }
    }

    private func part2() -> Int {
        let timer = Timer(day); defer { timer.show() }

        return addresses.count { $0.supportsSSL }
    }
}
