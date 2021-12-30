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

        return 0
    }

    struct RLE {
        let len, mul: Int
    }

    func decode(_ str: String) -> String {
        var result = ""

        var it = str.makeIterator()
        var rle: RLE?
        var tmp = ""
        while let ch = it.next() {
            if ch == "(" && rle == nil {
                var len = ""
                var mul = ""
                while let ch = it.next(), ch != "x" {
                    len.append(ch)
                }
                while let ch = it.next(), ch != ")" {
                    mul.append(ch)
                }
                rle = RLE(len: Int(len)!, mul: Int(mul)!)
            }
            else if let r = rle {
                tmp.append(ch)
                if tmp.count == r.len {
                    for _ in 0..<r.mul {
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
}
