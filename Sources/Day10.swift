//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/10
//
import AoCTools

final class Day10: AdventOfCodeDay {
    let title = "Balance Bots "

    enum Instruction {
        case lowToBot(Int)
        case highToBot(Int)
        case lowToOutput(Int)
        case highToOutput(Int)

        static func make(_ tokens: [String.SubSequence]) -> [Instruction] {
            //  0   1 2     3   4  5      6 7   8    9  10  11
            // "bot 1 gives low to output 1 and high to bot 0"
            assert(tokens[2] == "gives")
            let lowTarget = Int(tokens[6])!
            let low = tokens[5] == "bot" ? Instruction.lowToBot(lowTarget) : Instruction.lowToOutput(lowTarget)
            let highTarget = Int(tokens[11])!
            let high = tokens[10] == "bot" ? Instruction.highToBot(highTarget) : Instruction.highToOutput(highTarget)
            return [low, high]
        }
    }

    final class Bot: CustomStringConvertible {
        let id: Int
        var instructions: [Instruction]
        private(set) var values: [Int]

        var low: Int {
            assert(values.count == 2)
            return values[0]
        }

        var high: Int {
            assert(values.count == 2)
            return values[1]
        }

        var description: String {
            "id=\(id), values=\(values), instr=\(instructions)"
        }

        init(id: Int, _ instructions: [Instruction]) {
            self.id = id
            self.values = []
            self.instructions = instructions
        }

        init(id: Int, value: Int) {
            self.id = id
            self.values = [value]
            self.instructions = []
        }

        func receive(value: Int) {
            assert(values.count < 2)
            values.append(value)
            values.sort()
        }
    }

    final class Factory {
        var outputs = [Int: Int]()
        var bots = [Int: Bot]()

        init(_ bots: [Int: Bot]) {
            self.bots = bots
        }

        func executeInstructions() {
            let start = bots.values.first { $0.values.count == 2 }!

            executeInstructions(start)
        }

        private func executeInstructions(_ bot: Bot) {
            guard bot.values.count == 2, !bot.instructions.isEmpty else {
                return
            }

            for instruction in bot.instructions {
                switch instruction {
                case .lowToBot(let botId):
                    let receiver = bots[botId]!
                    receiver.receive(value: bot.low)
                    executeInstructions(receiver)
                case .highToBot(let botId):
                    let receiver = bots[botId]!
                    receiver.receive(value: bot.high)
                    executeInstructions(receiver)
                case .lowToOutput(let outputId):
                    outputs[outputId] = bot.low
                case .highToOutput(let outputId):
                    outputs[outputId] = bot.high
                }
            }
        }
    }

    var factory = Factory([:])

    init(input: String) {
        var bots = [Int: Bot]()
        for line in input.lines {
            let tokens = line.split(separator: " ")
            if tokens[0] == "value" {
                // "value 5 goes to bot 2"
                let value = Int(tokens[1])!
                let botId = Int(tokens[5])!
                if let bot = bots[botId] {
                    bot.receive(value: value)
                } else {
                    bots[botId] = Bot(id: botId, value: value)
                }
            } else {
                // "bot 2 gives low to bot 1 and high to bot 0"
                let instructions = Instruction.make(tokens)
                let botId = Int(tokens[1])!
                if let bot = bots[botId] {
                    bot.instructions = instructions
                } else {
                    bots[botId] = Bot(id: botId, instructions)
                }
            }
        }
        factory = Factory(bots)
    }

    func part1() async -> Int {
        part1and2().0
    }

    func part2() async -> Int {
        part1and2().1
    }

    private func part1and2() -> (Int, Int) {
        factory.executeInstructions()

        let result = factory.bots.values.filter { $0.values == [17, 61] }
        let id = result[0].id

        let outputs = (0...2)
            .map { factory.outputs[$0]! }
            .reduce(1, *)

        return (id, outputs)
    }
}
