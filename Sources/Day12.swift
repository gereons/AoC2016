//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/12
//
import AoCTools

final class Day12: AdventOfCodeDay {
    let title = "Leonardo's Monorail"

    enum Instruction {
        case cpy(String, String)
        case inc(String)
        case dec(String)
        case jnz(String, Int)

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
                self = .jnz(String(tokens[1]), Int(tokens[2])!)
            default: fatalError()
            }
        }
    }

    class CPU {
        var registers = [ "a": 0, "b": 0, "c": 0, "d": 0 ]
        private var pc = 0

        func run(program: [Instruction]) {
            while pc < program.count {
                execute(program[pc])
            }
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
                if value != 0 {
                    pc += offset
                } else {
                    pc += 1
                }
            }
        }
    }

    let instructions: [Instruction]

    init(input: String) {
        instructions = input.lines.map { Instruction($0) }
    }

    func part1() async -> Int {
        let cpu = CPU()
        cpu.run(program: instructions)

        return cpu.registers["a"]!
    }

    func part2() async -> Int {
        let cpu = CPU()
        cpu.registers["c"] = 1
        cpu.run(program: instructions)

        return cpu.registers["a"]!
    }
}
