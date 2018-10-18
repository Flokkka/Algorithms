//
//  SortInterface.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/1/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

protocol SortInterface: AlgorithmInterface {
    var worstCase: String { get }
    var averageCase: String { get }
    var bestCase: String { get }
    var memory: String { get }
    var stable: Bool { get }
    var method: String { get }

    func sort(_ a: inout [Int]) -> [SortSolutionStep]
}
