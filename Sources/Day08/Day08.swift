//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/8
//

import Foundation

final class Day08: Day {
    enum Command {
        case rect(x: Int, y: Int)
        case rotateColumn(x: Int, by: Int)
        case rotateRow(y: Int, by: Int)

        init(_ str: String) {
            let tokens = str.split(separator: " ")
            switch tokens[0] {
            case "rect":
                let xy = tokens[1].split(separator: "x")
                self = .rect(x: Int(xy[0])!, y: Int(xy[1])!)
            case "rotate":
                let xy = Int(tokens[2].split(separator: "=")[1])!
                let by = Int(tokens[4])!
                switch tokens[1] {
                case "column": self = .rotateColumn(x: xy, by: by)
                case "row": self = .rotateRow(y: xy, by: by)
                default: fatalError()
                }
            default: fatalError()
            }
        }
    }

    class Screen {
        private var pixels: [[Bool]]

        let maxX = 50
        let maxY = 6

        init() {
            let line = [Bool](repeating: false, count: maxX)
            pixels = [[Bool]](repeating: line, count: maxY)
        }

        func show() {
            for y in 0..<maxY {
                for x in 0..<maxX {
                    let ch = pixels[y][x] ? "#" : " "
                    print(ch, terminator: "")
                }
                print()
            }
            print()
        }

        func litPixels() -> Int {
            var cnt = 0
            for y in 0..<maxY {
                for x in 0..<maxX {
                    cnt += pixels[y][x] ? 1 : 0
                }
            }
            return cnt
        }

        func execute(_ command: Command) {
            switch command {
            case .rect(let x, let y):
                for y in 0..<y {
                    for x in 0..<x {
                        pixels[y][x] = true
                    }
                }
            case .rotateRow(let y, let by):
                rotateRow(y, by)
            case .rotateColumn(let x, let by):
                rotateColumn(x, by)
            }
        }

        private func rotateRow(_ y: Int, _ by: Int) {
            for _ in 0..<by {
                let tmp = pixels[y][maxX-1]
                for x in (0..<maxX-1).reversed() {
                    pixels[y][x+1] = pixels[y][x]
                }
                pixels[y][0] = tmp
            }
        }

        private func rotateColumn(_ x: Int, _ by: Int) {
            for _ in 0..<by {
                let tmp = pixels[maxY-1][x]
                for y in (0..<maxY-1).reversed() {
                    pixels[y+1][x] = pixels[y][x]
                }
                pixels[0][x] = tmp
            }
        }
    }

    let testData = [
        "rect 3x2",
        "rotate column x=1 by 1",
        "rotate row y=0 by 4",
        "rotate column x=1 by 1"
    ]

    var commands = [Command]()
    
    func run() {
        // let data = testData
        let data = Self.data.components(separatedBy: "\n")

        Timer.time(day) {
            commands = data.map { Command($0) }
        }

        print("Solution for part 1: \(part1())")
    }

    private func part1() -> Int {
        let timer = Timer(day); defer { timer.show() }

        let screen = Screen()
        commands.forEach {
            screen.execute($0)
        }
        screen.show()

        return screen.litPixels()
    }
}
