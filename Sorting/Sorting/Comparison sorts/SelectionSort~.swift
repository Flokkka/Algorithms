//
//  SelectionSort.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/1/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

class SelectionSort: SortInterface {
    
    var name: String = "Selection sort"
    var worstCase: String = "O(n\u{00B2})"
    var averageCase: String = "O(n\u{00B2})"
    var bestCase: String = "O(n\u{00B2})"
    var dataStructure: String = "array"
    var memory: String = "O(1)"
    var stable: Bool = false
    var method: String = "Selection"
    
    func sort(_ a: inout [Int]) -> [SortSolutionStep] {
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
            if (iMin != j) {
                let tempAJ = a[j]
                a[j] = a[iMin]
                a[iMin] = tempAJ
                steps.append(SortSolutionStep(a, .step))
            }
        }
        return steps
    }
    
    
}
