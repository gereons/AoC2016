//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/9
//
import AoCTools

final class Day09: AdventOfCodeDay {
    let title = "Explosives in Cyberspace"

    let lines: [String]

    init(input: String) {
        lines = input.lines
    }

    func part1() async -> Int {
        lines.reduce(0) { sum, line in
            sum + decode(line)
        }
    }

    func part2() async -> Int {
        lines.reduce(0) { sum, line in
            sum + decodeV2(line).reduce(0) { sum, rle in
                sum + rle.count()
            }
        }
    }

    final class RLE {
        let length, multiplier: Int
        var children: [RLE]?

        init(length: Int, multiplier: Int) {
            self.length = length
            self.multiplier = multiplier
        }

        func count() -> Int {
            if let children {
                let sum = children.reduce(0) { sum, rle in
                    sum + rle.count()
                }
                return sum * multiplier
            } else {
                return length * multiplier
            }
        }
    }

    private func decode(_ str: String) -> Int {
        var result = 0

        var it = str.makeIterator()
        var rle: RLE?
        var tmp = 0
        while let ch = it.next() {
            if ch == "(" && rle == nil {
                var len = 0
                var mul = 0
                while let ch = it.next(), ch != "x" {
                    len = len * 10 + Int(String(ch))!
                }
                while let ch = it.next(), ch != ")" {
                    mul = mul * 10 + Int(String(ch))!
                }
                rle = RLE(length: len, multiplier: mul)
            } else if let r = rle {
                tmp += 1
                if tmp == r.length {
                    result += r.length * r.multiplier
                    rle = nil
                    tmp = 0
                }
            } else {
                result += 1
            }
        }

        return result
    }

    private func decodeV2(_ str: String) -> [RLE] {
        var it = str.makeIterator()
        var result = [RLE]()

        while let ch = it.next() {
            if ch == "(" {
                var len = 0
                var mul = 0
                while let l = it.next(), l != "x" {
                    len = len * 10 + Int(String(l))!
                }
                while let m = it.next(), m != ")" {
                    mul = mul * 10 + Int(String(m))!
                }
                let rle = RLE(length: len, multiplier: mul)
                var str = ""
                for _ in 0..<len {
                    str.append(it.next()!)
                }
                rle.children = decodeV2(str)
                result.append(rle)
            } else {
                result.append(RLE(length: 1, multiplier: 1))
            }
        }

        return result
    }
}
