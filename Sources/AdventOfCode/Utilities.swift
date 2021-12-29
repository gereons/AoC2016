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
