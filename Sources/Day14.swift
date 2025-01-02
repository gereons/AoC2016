//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/14
//
import AoCTools

import CryptoKit

final class Day14: AdventOfCodeDay {
    let title = "One-Time Pad"
    let input: String

    init(input: String) {
        self.input = input
    }

    func part1() async -> Int {
        md5cache.removeAll()
        return oneTimePad(md5)
    }

    func part2() async -> Int {
        md5cache.removeAll()
        return oneTimePad(md5_2016)
    }

    private func oneTimePad(_ hashFun: (String) -> String) -> Int {
        var keys = [String]()
        var n = -1
        while keys.count < 64 {
            n += 1
            let md5 = hashFun("\(input)\(n)")
            if let ch = triplet(in: md5) {
                // print("triplet for", n)
                if findQintuplet(n, ch, hashFun) {
                    keys.append(md5)
                    // print(keys.count)
                }
            }
        }

        return n
    }

    private func triplet(in str: String) -> Character? {
        let chars = Array(str)
        for i in 0..<chars.count - 2 {
            if chars[i] == chars[i + 1] && chars[i] == chars[i + 2] {
                return chars[i]
            }
        }
        return nil
    }

    private func findQintuplet(_ n: Int, _ ch: Character, _ hashFun: (String) -> String) -> Bool {
        for n in n + 1 ... n + 1001 {
            let md5 = hashFun("\(input)\(n)")
            let chars = Array(md5)
            for i in 0..<chars.count - 4 {
                if chars[i] != ch { continue }
                if chars[i] == chars[i + 1] &&
                    chars[i] == chars[i + 2] &&
                    chars[i] == chars[i + 3] &&
                    chars[i] == chars[i + 4] {
                    // print("quintuplet at", n)
                    return true
                }
            }
        }
        return false
    }

    private var md5cache = [String: String]()

    private func md5(_ str: String) -> String {
        if let md5 = md5cache[str] {
            return md5
        } else {
            let hex = rawMD5(str)
            md5cache[str] = hex
            return hex
        }
    }

    private func md5_2016(_ str: String) -> String {
        if let md5 = md5cache[str] {
            return md5
        } else {
            var m = rawMD5(str)
            for _ in 1...2016 {
                m = rawMD5(m)
            }
            md5cache[str] = m
            return m
        }
    }

    private func rawMD5(_ str: String) -> String {
        let data = str.data(using: .utf8)!
        let md5 = Array(Insecure.MD5.hash(data: data))
        return md5.map { String(format: "%02hhx", $0) }.joined()
    }
}
