//
// Advent of Code 2016
//
// https://adventofcode.com/2016/day/19
//

final class Day19: Day {
    class Elf: CustomStringConvertible {
        let id: Int
        var presents = 1
        var next: Elf? = nil

        init(id: Int) {
            self.id = id
        }

        var description: String {
            "\(id): \(presents)"
        }
    }

    func run() {
        let elves = Int(Self.data)!

        print("Solution for part 1: \(part1(elves))")
        print("Solution for part 2: \(part2(elves))")
    }

    private func part1(_ count: Int) -> Int {
        let timer = Timer(day); defer { timer.show() }

        let head = createRing(count)

        var current = head
        var count = count
        while count > 1 {
            let next = current?.next
            current?.presents += next?.presents ?? 0
            current?.next = next?.next

            current = current?.next
            count -= 1
        }

        return current!.id
    }

    private func part2(_ count: Int) -> Int {
        let timer = Timer(day); defer { timer.show() }

        var left = List(1...count/2)
        var right = List((count/2+1...count).reversed())

        while left.count + right.count > 1 {
            if left.count > right.count {
                left.removeLast()
            } else {
                right.removeFirst()
            }

            right.append(left.removeFirst()!)
            left.append(right.removeFirst()!)
        }

        return left.first ?? right.first!
    }

    private func createRing(_ count: Int) -> Elf? {
        var head: Elf? = nil
        var prev: Elf? = nil

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
