//
//  InsertionSort.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/1/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

struct InsertionSort: SortInterface {

    public var name = "Insertion sort"
    public var worstCase = "O(n\u{00B2})"
    public var averageCase = "O(n\u{00B2})"
    public var bestCase = "O(n)"
    public var memory = "O(1)"
    public var stable = true
    public var method = "Insertion"

    public func sort(_ a: inout [Int]) -> [SortSolutionStep] {
        var steps: [SortSolutionStep] = []
        var i = 1
        while i < a.count {
            steps.append(SortSolutionStep([i], .indices))
            var j = i
            while j > 0 && a[j-1] > a[j] {
                let tempAJ = a[j]
                a[j] = a[j-1]
                a[j-1] = tempAJ
                j -= 1
                steps.append(SortSolutionStep([i, j], .indices))
                steps.append(SortSolutionStep(a, .step))
            }
            i += 1
        }
        return steps
    }
}
