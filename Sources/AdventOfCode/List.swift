//
//  List.swift
//
//  Advent of Code 2016
//

// doubly-linked list, adding/removing elements at start and end are O(1)

struct List<Element> {
    private class ListNode {
        let element: Element
        var next: ListNode? = nil
        var prev: ListNode? = nil

        init(_ element: Element) {
            self.element = element
        }
    }

    private var head: ListNode? = nil
    private var tail: ListNode? = nil
    private(set) var count = 0
    
    var isEmpty: Bool {
        head == nil
    }

    var first: Element? {
        head?.element
    }

    var last: Element? {
        tail?.element
    }

    init() { }

    init<S: Sequence>(_ elements: S) where S.Element == Element {
        elements.forEach { append($0) }
    }

    mutating func prepend(_ element: Element) {
        makeUnique()
        let node = ListNode(element)
        if head == nil {
            head = node
            tail = node
        } else {
            head?.prev = node
            node.next = head
            head = node
        }
        count += 1
    }

    mutating func append(_ element: Element) {
        makeUnique()
        let node = ListNode(element)
        if tail == nil {
            head = node
            tail = node
        } else {
            node.prev = tail
            tail?.next = node
            tail = node
        }
        count += 1
    }

    @discardableResult
    mutating func removeFirst() -> Element? {
        makeUnique()
        count -= 1
        let headNode = head
        head = head?.next
        head?.prev = nil
        if head == nil {
            tail = nil
        }
        headNode?.next = nil
        headNode?.prev = nil
        return headNode?.element
    }

    @discardableResult
    mutating func removeLast() -> Element? {
        makeUnique()
        count -= 1
        let tailNode = tail
        tail = tail?.prev
        tail?.next = nil
        if tail == nil {
            head = nil
        }
        tailNode?.next = nil
        tailNode?.prev = nil
        return tailNode?.element
    }

    // MARK: - Copy-on-write
    private final class Sentinel {}
    private var sentinel = Sentinel()

    private var isUnique: Bool {
        mutating get { isKnownUniquelyReferenced(&sentinel) }
    }

    private mutating func makeUnique() {
        guard !isUnique else { return }

        var newHead: ListNode? = nil
        var newTail: ListNode? = nil

        print("copy! \(count)")
        var node = head
        while node != nil {
            let copy = ListNode(node!.element)
            if newHead == nil {
                newHead = copy
            }
            copy.prev = newTail
            newTail?.next = copy
            newTail = copy

            node = node?.next
        }

        head = newHead
        tail = newTail
    }
}

struct Queue<Element> {
    private var storage: List<Element>

    init() {
        storage = List()
    }

    var isEmpty: Bool { storage.isEmpty }
    var count: Int { storage.count }

    mutating func push(_ element: Element) {
        storage.append(element)
    }

    mutating func pop() -> Element? {
        storage.removeFirst()
    }

    func peek() -> Element? {
        storage.first
    }
}
