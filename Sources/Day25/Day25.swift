//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/25
//

final class Day25: Day {

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

    class CPU {
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

    var instructions = [Instruction]()

    func run() {
        let data = Self.data.components(separatedBy: "\n")
        Timer.time(day) {
            instructions = data.map { Instruction($0) }
        }

        print("Solution for part 1: \(part1())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        let len = 20
        let check = String(repeating: "01", count: len/2)
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
}
