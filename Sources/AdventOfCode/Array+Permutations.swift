//
//  Array+Permutations.swift
//  
//  Advent of Code 2016
//

// see https://en.wikipedia.org/wiki/Heap%27s_algorithm

extension Array {
    func permutations(closure: ([Element]) -> Void) {
        var data = self
        generate(n: data.count, data: &data, closure: closure)
    }

    private func generate(n: Int, data: inout [Element], closure: ([Element]) -> Void) {
        if n == 1 {
            closure(data)
        } else {
            for i in 0 ..< n {
                generate(n: n - 1, data: &data, closure: closure)
                if n % 2 == 0 {
                    data.swapAt(i, n - 1)
                } else {
                    data.swapAt(0, n - 1)
                }
            }
        }
    }
}
