//
//  MergeSort.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/2/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

struct MergeSort: SortInterface {

    public var name = "Merge sort"
    public var worstCase = "O(n log n)"
    public var averageCase = "O(n log n)"
    public var bestCase = "O(n log n)"
    public var memory = "O(n)"
    public var stable = true
    public var method = "Merging"

    public func sort(_ a: inout [Int]) -> [SortSolutionStep] {
        var steps: [SortSolutionStep] = []
        mergeSort(a: &a, l: 0, r: a.count - 1, steps: &steps)
        return steps
    }

    private func mergeSort(a: inout [Int], l: Int, r: Int, steps: inout [SortSolutionStep]) {
        if l >= r {
            return
        }
        let m: Int = (l + r) / 2
        steps.append(SortSolutionStep([l, r], .indices))
        mergeSort(a: &a, l: l, r: m, steps: &steps)
        mergeSort(a: &a, l: m + 1, r: r, steps: &steps)
        var j = l
        var k = m + 1
        var b = [Int](0 ..< r-l+1)
        for i in 0...r - l {
            if j > m {
                b[i] = a[k]
                k += 1
            } else if k > r {
                b[i] = a[j]
                j += 1
            } else {
                if a[j] <= a[k] {
                    b[i] = a[j]
                    j += 1
                } else {
                    b[i] = a[k]
                    k += 1
                }
            }
        }
        for i in 0...r - l {
            a[l+i] = b[i]
            steps.append(SortSolutionStep(a, .step))
        }
    }
}
