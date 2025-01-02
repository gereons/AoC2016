//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/25
//
import AoCTools

final class Day25: AdventOfCodeDay {
    let title = "Clock Signal"

    // like Day12, but with `out`
    enum Instruction {
        case cpy(String, String)
        case inc(String)
        case dec(String)
        case jnz(String, String)
        case out(String)

        init(_ str: String) {
            let tokens = str.split(separator: " ")
            switch tokens[0] {
            case "cpy":
                self = .cpy(String(tokens[1]), String(tokens[2]))
            case "inc":
                self = .inc(String(tokens[1]))
            case "dec":
                self = .dec(String(tokens[1]))
            case "jnz":
                self = .jnz(String(tokens[1]), String(tokens[2]))
            case "out":
                self = .out(String(tokens[1]))
            default: fatalError()
            }
        }
    }

    final class CPU {
        var registers = [ "a": 0, "b": 0, "c": 0, "d": 0 ]
        private var pc = 0
        private var output = ""

        func run(program: [Instruction]) {
            while pc < program.count {
                execute(program[pc])
            }
        }

        func run(program: [Instruction], outputLen: Int) -> String {
            while pc < program.count && output.count < outputLen {
                execute(program[pc])
            }
            return output
        }

        private func execute(_ instruction: Instruction) {
            switch instruction {
            case .cpy(let from, let to):
                let value = Int(from) ?? registers[from]!
                registers[to] = value
                pc += 1
            case .inc(let reg):
                registers[reg]! += 1
                pc += 1
            case .dec(let reg):
                registers[reg]! -= 1
                pc += 1
            case .jnz(let value, let offset):
                let value = Int(value) ?? registers[value]!
                let offset = Int(offset) ?? registers[offset]!
                if value != 0 {
                    pc += offset
                } else {
                    pc += 1
                }
            case .out(let arg):
                output.append(String(registers[arg]!))
                pc += 1
            }
        }
    }

    let instructions: [Instruction]

    init(input: String) {
        instructions = input.lines.map { Instruction($0) }
    }

    func part1() async -> Int {
        let len = 20
        let check = String(repeating: "01", count: len / 2)
        for i in 0...100000 {
            let cpu = CPU()
            cpu.registers["a"] = i
            let output = cpu.run(program: instructions, outputLen: len)
            if output == check {
                return i
            }
        }

        return -1
    }

    func part2() async -> Int {
        0
    }
}
