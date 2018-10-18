//
//  GraphInterface.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/7/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

protocol GraphInterface: AlgorithmInterface {

    var worstCasePerformance: String { get }
    var limitations: String { get }

    func go(start: Int, graph: Graph) -> [GraphSolutionStep]
}
