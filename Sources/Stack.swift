//
//  Stack.swift
//  
//  Advent of Code 2016
//

struct Stack<Element> {
    private var storage: [Element]

    init() {
        storage = []
    }

    var count: Int { storage.count }
    var isEmpty: Bool { storage.isEmpty }

    mutating func push(_ element: Element) {
        storage.append(element)
    }

    mutating func pop() -> Element {
        storage.removeLast()
    }

    func peek() -> Element? {
        storage.last
    }
}
