//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/19
//

import AoCTools
import Collections

final class Day19: AdventOfCodeDay {
    let title = "An Elephant Named Joseph"

    final class Elf: CustomStringConvertible {
        let id: Int
        var presents = 1
        var next: Elf?

        init(id: Int) {
            self.id = id
        }

        var description: String {
            "\(id): \(presents)"
        }
    }

    let elves: Int

    init(input: String) {
        elves = Int(input)!
    }

    func part1() async -> Int {
        let head = createRing(elves)

        var current = head
        var count = elves
        while count > 1 {
            let next = current?.next
            current?.presents += next?.presents ?? 0
            current?.next = next?.next

            current = current?.next
            count -= 1
        }

        return current!.id
    }

    func part2() async -> Int {
        var left = Deque(1 ... elves / 2)
        var right = Deque((elves / 2 + 1 ... elves).reversed())

        while left.count + right.count > 1 {
            if left.count > right.count {
                left.removeLast()
            } else {
                right.removeFirst()
            }

            right.append(left.removeFirst())
            left.append(right.removeFirst())
        }

        return left.first ?? right.first!
    }

    private func createRing(_ count: Int) -> Elf? {
        var head: Elf?
        var prev: Elf?

        for id in 1...count {
            let elf = Elf(id: id)
            if head == nil {
                head = elf
            }
            prev?.next = elf
            prev = elf
        }
        prev?.next = head

        return head
    }
}
