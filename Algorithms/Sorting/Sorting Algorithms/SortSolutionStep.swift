//
//  SortSolutionStep.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/3/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

struct SortSolutionStep {
    enum SSType {
        case step
        case indices
    }

    public let element: [Int]
    public let type: SSType

    init(_ element: [Int], _ type: SSType) {
        self.element = element
        self.type = type
    }
}
