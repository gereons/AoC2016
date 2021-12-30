//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/9
//

final class Day09: Day {
    let testData = [
        ("ADVENT", "ADVENT"),
        ("A(1x5)BC", "ABBBBBC"),
        ("(3x3)XYZ", "XYZXYZXYZ"),
        ("A(2x2)BCD(2x2)EFG", "ABCBCDEFEFG"),
        ("(6x1)(1x3)A", "(1x3)A"),
        ("X(8x2)(3x3)ABCY", "X(3x3)ABC(3x3)ABCY")
    ]

    func run() {
        let data = Self.data.components(separatedBy: "\n")

        print("Solution for part 1: \(part1(data))")
        print("Solution for part 2: \(part2(data))")
    }

    private func part1(_ data: [String]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        return data.reduce(0) { sum, line in
            sum + decode(line).count
        }
    }

    private func part2(_ data: [String]) -> Int {
        let timer = Timer(day); defer { timer.show() }

        return data.reduce(0) { sum, line in
            sum + decodeV2(line).reduce(0) { sum, rle in
                sum + rle.count()
            }
        }
    }

    class RLE {
        let length, multiplier: Int
        var children: [RLE]?

        init(length: Int, multiplier: Int) {
            self.length = length
            self.multiplier = multiplier
        }

        func count() -> Int {
            if let children = children {
                let sum = children.reduce(0) { sum, rle in
                    sum + rle.count()
                }
                return sum * multiplier
            } else {
                return length * multiplier
            }
        }
    }

    func decode(_ str: String) -> String {
        var result = ""

        var it = str.makeIterator()
        var rle: RLE?
        var tmp = ""
        while let ch = it.next() {
            if ch == "(" && rle == nil {
                var len = 0
                var mul = 0
                while let ch = it.next(), ch != "x" {
                    len = len*10 + Int(String(ch))!
                }
                while let ch = it.next(), ch != ")" {
                    mul = mul*10 + Int(String(ch))!
                }
                rle = RLE(length: len, multiplier: mul)
            }
            else if let r = rle {
                tmp.append(ch)
                if tmp.count == r.length {
                    for _ in 0..<r.multiplier {
                        result.append(tmp)
                    }
                    rle = nil
                    tmp = ""
                }
            } else {
                result.append(ch)
            }
        }

        return result
    }

    func decodeV2(_ str: String) -> [RLE] {
        var it = str.makeIterator()
        return decodeRLE(&it)
    }

    func decodeRLE(_ it: inout String.Iterator) -> [RLE] {
        var result = [RLE]()
        while let ch = it.next() {
            if ch == "(" {
                var len = 0
                var mul = 0
                while let l = it.next(), l != "x" {
                    len = len*10 + Int(String(l))!
                }
                while let m = it.next(), m != ")" {
                    mul = mul*10 + Int(String(m))!
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
