//
//  GraphSolutionStep.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/7/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

struct GraphSolutionStep {
    
    public let dist: [Int]
    public let pred: [Int]
    public let successors: [Int]
    public let vertice: Int?
    public let edge: Int?
    public let negativeWeightCycle: Bool
    
    init(dist: [Int], pred: [Int], successors: [Int] = [], vertice: Int? = nil, edge: Int? = nil, negativeWeightCycle: Bool = false) {
        self.dist = dist
        self.pred = pred
        self.successors = successors
        self.vertice = vertice
        self.edge = edge
        self.negativeWeightCycle = negativeWeightCycle
    }
}
