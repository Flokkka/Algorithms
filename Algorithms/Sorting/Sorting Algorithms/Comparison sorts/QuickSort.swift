//
//  QuickSort.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/2/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

struct QuickSort: SortInterface {
    
    public var name: String = "Quicksort"
    public var worstCase: String = "O(n\u{00B2})"
    public var averageCase: String = "O(n log n)"
    public var bestCase: String = "O(n log n)"
    public var memory: String = "average-case: O(log n)\nworst-case: O(n)"
    public var stable: Bool = false
    public var method: String = "Partitioning"
    
    public func sort(_ a: inout [Int]) -> [SortSolutionStep] {
        var steps: [SortSolutionStep] = []
        quickSort(a: &a, l: 0, r: a.count - 1, steps: &steps)
        return steps
    }
    
    private func quickSort(a: inout [Int], l: Int, r: Int, steps: inout [SortSolutionStep]) {
        if l < r {
            let p = a[r] //choose the most right element as pivot
            steps.append(SortSolutionStep([r], .indices))
            var i = l - 1
            steps.append(SortSolutionStep([r, i], .indices))
            var j = r
            steps.append(SortSolutionStep([r, i, j], .indices))
            repeat {
                repeat {
                    i += 1
                    steps.append(SortSolutionStep([r, i, j], .indices))
                } while a[i] < p
                repeat {
                    j -= 1
                    steps.append(SortSolutionStep([r, i, j], .indices))
                } while j >= l && a[j] > p
                if i < j {
                    let tempAI = a[i]
                    a[i] = a[j]
                    a[j] = tempAI
                    steps.append(SortSolutionStep(a, .step))
                }
            } while i < j
            let tempAI = a[i]
            a[i] = a[r]
            a[r] = tempAI
            steps.append(SortSolutionStep(a, .step))
            quickSort(a: &a, l: l, r: i-1, steps: &steps)
            quickSort(a: &a, l: i+1, r: r, steps: &steps)
        }
    }
    
    
}
