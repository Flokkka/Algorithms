//
//  BubbleSort.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/3/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

struct BubbleSort: SortInterface {
    
    public var name: String = "Bubble sort"
    public var worstCase: String = "O(n\u{00B2})"
    public var averageCase: String = "O(n\u{00B2})"
    public var bestCase: String = "O(n)"
    public var memory: String = "O(1)"
    public var stable: Bool = true
    public var method: String = "Exchanging"
    
    public func sort(_ a: inout [Int]) -> [SortSolutionStep] {
        var steps: [SortSolutionStep] = []
        var i = 1
        while i < a.count {
            steps.append(SortSolutionStep([a.count-i], .indices))
            for j in 0..<a.count-i {
                steps.append(SortSolutionStep([a.count-i, j], .indices))
                if a[j] > a[j+1] {
                    let tempAJ = a[j]
                    a[j] = a[j+1]
                    a[j+1] = tempAJ
                    steps.append(SortSolutionStep(a, .step))
                }
            }
            i += 1
        }
        return steps
    }
    
    
}
