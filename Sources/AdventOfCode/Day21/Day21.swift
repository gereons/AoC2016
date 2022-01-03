//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/21
//

final class Day21: Day {
    let testData = [
        "swap position 4 with position 0",
        "swap letter d with letter b",
        "reverse positions 0 through 4",
        "rotate left 1 step",
        "move position 1 to position 4",
        "move position 3 to position 0",
        "rotate based on position of letter b",
        "rotate based on position of letter d"
    ]

    func run() {
        // let data = testData
        let data = Self.data.components(separatedBy: "\n")

        print("Solution for part 1: \(part1(data))")
        print("Solution for part 2: \(part2(data))")
    }

    private func part1(_ data: [String]) -> String {
        let timer = Timer(day); defer { timer.show() }

        let password = scramble(data, "abcdefgh")
        return password
    }

    private func part2(_ data: [String]) -> String {
        let timer = Timer(day); defer { timer.show() }
        let password = scramble(data.reversed(), "fbgdceah", reverse: true)
        return password
    }

    private func scramble(_ data: [String], _ input: String, reverse: Bool = false) -> String {
        var chars = input.map { $0 }
        for line in data {
            scramble(line, &chars, reverse)
        }
        return chars.map { String($0) }.joined()
    }

    private func scramble(_ line: String, _ chars: inout [Character], _ reverse: Bool) {
        let tokens = line.split(separator: " ")

        switch tokens[0] {
        case "swap":
            swap(tokens, &chars)
        case "reverse":
            self.reverse(tokens, &chars)
        case "rotate":
            rotate(tokens, &chars, reverse)
        case "move":
            move(tokens, &chars, reverse)
        default: fatalError()
        }
    }

    private func swap(_ tokens: [String.SubSequence], _ chars: inout [Character]) {
        switch tokens[1] {
        case "position":
            let p1 = Int(tokens[2])!
            let p2 = Int(tokens[5])!
            chars.swapAt(p1, p2)
        case "letter":
            let l1 = Character(String(tokens[2]))
            let l2 = Character(String(tokens[5]))
            chars = chars.map { $0 == l2 ? "_" : $0 }
            chars = chars.map { $0 == l1 ? l2 : $0 }
            chars = chars.map { $0 == "_" ? l1 : $0 }
        default: fatalError()
        }
    }

    private func reverse(_ tokens: [String.SubSequence], _ chars: inout [Character]) {
        let p1 = Int(tokens[2])!
        let p2 = Int(tokens[4])!

        let reversed = chars[p1...p2].reversed()
        chars.replaceSubrange(p1...p2, with: reversed)
    }

    private func rotate(_ tokens: [String.SubSequence], _ chars: inout [Character], _ reverse: Bool) {
        func rotRight(_ steps: Int) {
            for _ in 0..<steps {
                let ch = chars.removeLast()
                chars.insert(ch, at: 0)
            }
        }

        func rotLeft(_ steps: Int) {
            for _ in 0..<steps {
                let ch = chars.removeFirst()
                chars.append(ch)
            }
        }

        switch tokens[1] {
        case "left":
            let steps = Int(tokens[2])!
            reverse ? rotRight(steps) : rotLeft(steps)
        case "right":
            let steps = Int(tokens[2])!
            reverse ? rotLeft(steps) : rotRight(steps)
        case "based":
            let ch = Character(String(tokens[6]))
            let index = chars.firstIndex(of: ch)!
            if reverse {
                switch index {
                case 0: rotLeft(1)
                case 1: rotLeft(1)
                case 2: rotRight(2)
                case 3: rotLeft(2)
                case 4: rotRight(1)
                case 5: rotLeft(3)
                case 6: () // nop
                case 7: rotLeft(4)
                default: fatalError()
                }

            } else {
                let steps = index > 3 ? index + 2 : index + 1
                rotRight(steps)
            }
        default: fatalError()
        }
    }

    private func move(_ tokens: [String.SubSequence], _ chars: inout [Character], _ reverse: Bool) {
        assert(tokens[1] == "position")
        let p1 = Int(tokens[2])!
        let p2 = Int(tokens[5])!

        if reverse {
            let ch = chars.remove(at: p2)
            chars.insert(ch, at: p1)
        } else {
            let ch = chars.remove(at: p1)
            chars.insert(ch, at: p2)
        }
    }
}
