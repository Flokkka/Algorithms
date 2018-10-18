//
//  HeapSort.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/3/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

struct HeapSort: SortInterface {

    public var name = "Heapsort"
    public var worstCase = "O(n log n)"
    public var averageCase = "O(n log n)"
    public var bestCase = "O(n log n)"
    public var memory = "O(1)"
    public var stable = false
    public var method = "Selection"

    public func sort(_ a: inout [Int]) -> [SortSolutionStep] {
        var steps: [SortSolutionStep] = []
        var i: Int = a.count / 2 - 1
        while i >= 0 {
            steps.append(SortSolutionStep([i], .indices))
            heapify(a: &a, n: a.count, i: i, steps: &steps)
            i -= 1
        }
        i = a.count - 1
        while i >= 0 {
            steps.append(SortSolutionStep([i], .indices))
            let tempA0 = a[0]
            a[0] = a[i]
            a[i] = tempA0
            steps.append(SortSolutionStep(a, .step))
            heapify(a: &a, n: i, i: 0, steps: &steps)
            i -= 1
        }
        return steps
    }

    private func heapify(a: inout [Int], n: Int, i: Int, steps: inout [SortSolutionStep]) {
        var largest = i
        let l = 2 * i + 1
        let r = 2 * i + 2
        if l < n && a[l] > a[largest] {
            largest = l
        }
        if r < n && a[r] > a[largest] {
            largest = r
        }
        if largest != i {
            let tempAI = a[i]
            a[i] = a[largest]
            a[largest] = tempAI
            steps.append(SortSolutionStep(a, .step))
            heapify(a: &a, n: n, i: largest, steps: &steps)
        }
    }
}
