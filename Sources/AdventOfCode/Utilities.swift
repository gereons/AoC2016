//
//  Utilities.swift
//
//  Advent of Code 2016
//

import Foundation

extension String {
    func trimmed() -> String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    mutating func trim() {
        self = self.trimmed()
    }

    func charAt(_ offset: Int) -> String {
        let ch = self[index(startIndex, offsetBy: offset)]
        return String(ch)
    }

    func indexOf(_ substr: String) -> Int? {
        guard let range = self.range(of: substr) else {
            return nil
        }

        return distance(from: startIndex, to: range.lowerBound)
    }

    func indicesOf(_ substr: String) -> [Int] {
        var result = [Int]()
        var searchRange = startIndex..<endIndex
        while let r = self.range(of: substr, range: searchRange) {
            result.append(distance(from: startIndex, to: r.lowerBound))
            searchRange = index(r.lowerBound, offsetBy: 1)..<endIndex
        }
        return result
    }
}

extension Sequence {
    func count(where condition: (Element) -> Bool) -> Int {
        var cnt = 0
        self.forEach {
            if condition($0) { cnt += 1}
        }
        return cnt
    }
}

struct Point: Hashable, CustomStringConvertible {
    let x, y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    var description: String {
        "\(x),\(y)"
    }
}
