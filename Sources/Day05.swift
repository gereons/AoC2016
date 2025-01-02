//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/5
//
import AoCTools

import CryptoKit

final class Day05: AdventOfCodeDay {
    let title = "How About a Nice Game of Chess?"

    let input: String

    init(input: String) {
        self.input = input
    }

    func part1() async -> String {
        var digits = [Character]()
        for num in 0..<100_000_000 {
            let str = "\(input)\(num)"
            let data = str.data(using: .utf8)!
            let md5 = Array(Insecure.MD5.hash(data: data))
            if md5[0] == 0 && md5[1] == 0 && md5[2] & 0xf0 == 0 {
                let hex = md5.map { String(format: "%02hhx", $0) }.joined()
                let digit = hex[hex.index(hex.startIndex, offsetBy: 5)]
                // print(num, digit, hex)
                digits.append(digit)
                if digits.count == 8 {
                    return String(digits)
                }
            }
        }

        fatalError()
    }

    func part2() async -> String {
        var digits = [Character](repeating: " ", count: 8)
        var count = 0
        for num in 0..<100_000_000 {
            let str = "\(input)\(num)"
            let data = str.data(using: .utf8)!
            let md5 = Array(Insecure.MD5.hash(data: data))
            if md5[0] == 0 && md5[1] == 0 && md5[2] & 0xf0 == 0 {
                let hex = md5.map { String(format: "%02hhx", $0) }.joined()
                let position = Int(md5[2] & 0x0f)
                if position >= digits.count || digits[position] != " " {
                    continue
                }
                let digit = hex[hex.index(hex.startIndex, offsetBy: 6)]
                // print(num, position, digit, hex)
                digits[position] = digit
                count += 1
                if count == digits.count {
                    return String(digits)
                }
            }
        }

        fatalError()
    }
}
