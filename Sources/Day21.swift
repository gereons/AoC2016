//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/21
//
import AoCTools

final class Day21: AdventOfCodeDay {
    let title = "Scrambled Letters and Hash"

    let instructions: [String]

    init(input: String) {
        self.instructions = input.lines
    }

    func part1() async -> String {
        await part1(input: "abcdefgh")
    }

    func part1(input: String) async -> String {
        return scramble(instructions, input)
    }

    func part2() async -> String {
        let password = scramble(instructions.reversed(), "fbgdceah", reverse: true)
        return password
    }

    private func scramble(_ instructions: [String], _ input: String, reverse: Bool = false) -> String {
        var chars = Array(input)
        for instruction in instructions {
            scramble(instruction, &chars, reverse)
        }
        return chars.map { String($0) }.joined()
    }

    private func scramble(_ instruction: String, _ chars: inout [Character], _ reverse: Bool) {
        let tokens = instruction.split(separator: " ")

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

        let reversed = Array(chars[p1...p2].reversed())
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
            if reverse { rotRight(steps) } else { rotLeft(steps) }
        case "right":
            let steps = Int(tokens[2])!
            if reverse { rotLeft(steps) } else { rotRight(steps) }
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
