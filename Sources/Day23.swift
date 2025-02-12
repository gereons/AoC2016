//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/23
//
import AoCTools

final class Day23: AdventOfCodeDay {
    let title = "Safe Cracking"

    // like Day12, but with `tgl`
    enum Instruction {
        case cpy(String, String)
        case inc(String)
        case dec(String)
        case jnz(String, String)
        case tgl(String)

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
            case "tgl":
                self = .tgl(String(tokens[1]))
            default: fatalError()
            }
        }
    }

    final class CPU {
        var registers = [ "a": 0, "b": 0, "c": 0, "d": 0 ]
        private var program = [Instruction]()
        private var pc = 0

        func run(program: [Instruction]) {
            self.program = program

            while pc < self.program.count {
                execute(self.program[pc])
            }
        }

        private func execute(_ instruction: Instruction) {
            switch instruction {
            case .cpy(let from, let to):
                let value = Int(from) ?? registers[from]!
                if Int(to) == nil { // "cpy 1 2" does nothing
                    registers[to] = value
                }
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
            case .tgl(let arg):
                let offset = Int(arg) ?? registers[arg]!
                let idx = pc + offset
                if idx >= 0 && idx < program.count {
                    switch program[idx] {
                    case .inc(let arg):
                        program[idx] = .dec(arg)
                    case .dec(let arg), .tgl(let arg):
                        program[idx] = .inc(arg)
                    case .cpy(let arg1, let arg2):
                        program[idx] = .jnz(arg1, arg2)
                    case .jnz(let arg1, let arg2):
                        program[idx] = .cpy(arg1, arg2)
                    }
                }
                pc += 1
            }
        }
    }

    let instructions: [Instruction]

    init(input: String) {
        instructions = input.lines.map { Instruction($0) }
    }

    func part1() async -> Int {
        let cpu = CPU()
        cpu.registers["a"] = 7
        cpu.run(program: instructions)
        return cpu.registers["a"]!
    }

    func part2() async -> Int {
        let cpu = CPU()
        cpu.registers["a"] = 12
        cpu.run(program: instructions)
        return cpu.registers["a"]!
    }
}
