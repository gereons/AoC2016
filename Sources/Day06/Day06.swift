//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/6
//

final class Day06: Day {
    let testData = [
        "eedadn",
        "drvtee",
        "eandsr",
        "raavrd",
        "atevrs",
        "tsrnev",
        "sdttsa",
        "rasrtv",
        "nssdts",
        "ntnada",
        "svetve",
        "tesnvt",
        "vntsnd",
        "vrdear",
        "dvrsen",
        "enarar"
    ]

    var chars = [[Character]]()

    func run() {
        // let data = testData
        let data = Self.data.components(separatedBy: "\n")

        Timer.time(day) {
            chars = data.map { line in
                line.map { $0 }
            }
        }

        print("Solution for part 1: \(part1())")
        print("Solution for part 2: \(part2())")
    }

    private func part1() -> String {
        let timer = Timer(day); defer { timer.show() }

        var decrypted = ""
        for i in 0 ..< chars[0].count {
            var charCount = [Character: Int]()
            for j in 0 ..< chars.count {
                charCount[chars[j][i], default: 0] += 1
            }
            let ch = charCount.sorted { $0.value > $1.value }.first?.key
            decrypted.append(ch!)
        }
        return decrypted
    }

    private func part2() -> String {
        let timer = Timer(day); defer { timer.show() }
        var decrypted = ""
        for i in 0 ..< chars[0].count {
            var charCount = [Character: Int]()
            for j in 0 ..< chars.count {
                charCount[chars[j][i], default: 0] += 1
            }
            let ch = charCount.sorted { $0.value < $1.value }.first?.key
            decrypted.append(ch!)
        }
        return decrypted
    }
}
