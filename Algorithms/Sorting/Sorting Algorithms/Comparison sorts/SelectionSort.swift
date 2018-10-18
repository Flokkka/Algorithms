//
//  SelectionSort.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/1/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

struct SelectionSort: SortInterface {

    public var name = "Selection sort"
    public var worstCase = "O(n\u{00B2})"
    public var averageCase = "O(n\u{00B2})"
    public var bestCase = "O(n\u{00B2})"
    public var memory = "O(1)"
    public var stable = false
    public var method = "Selection"

    public func sort(_ a: inout [Int]) -> [SortSolutionStep] {
        var steps: [SortSolutionStep] = []
        for j in 0..<a.count {
            steps.append(SortSolutionStep([j], .indices))
            var iMin = j
            for i in j+1..<a.count {
                if a[i] < a[iMin] {
                    iMin = i
                }
                steps.append(SortSolutionStep([j, i], .indices))
            }
            if iMin != j {
                let tempAJ = a[j]
                a[j] = a[iMin]
                a[iMin] = tempAJ
                steps.append(SortSolutionStep(a, .step))
            }
        }
        return steps
    }
}
