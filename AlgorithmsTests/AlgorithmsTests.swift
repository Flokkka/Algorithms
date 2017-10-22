//
//  AlgorithmsTests.swift
//  AlgorithmsTests
//
//  Created by Florian Kasten on 9/1/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import XCTest
@testable import Algorithms

class AlgorithmsTests: XCTestCase {
    
    func testSorting() {
        let algorithms: [SortInterface] = [InsertionSort(), SelectionSort(), BubbleSort(), QuickSort(), MergeSort(), HeapSort()]
        
        for alg in algorithms {
            var a = [[4, 3, 5, 2, 1], [5, 8, 3, 5, 8, 9, 0, -3, -5, 23], [1, 2, 3], [3, 2, 1], [], [1]]
            let aSorted = [[1, 2, 3, 4, 5], [-5, -3, 0, 3, 5, 5, 8, 8, 9, 23], [1, 2, 3], [1, 2, 3], [], [1]]
            
            for i in 0..<a.count {
                _ = alg.sort(&a[i])
                XCTAssert(a[i] == aSorted[i], "Sorting failed for \(a[i]) (\(alg.name))")
            }
        }
    }
    
    func testGraphs() {
        let graphP = Graph(canHaveNegativeEdges: false, weights:  [4, 5, 2, 7, 9, 5, 3, 2, 8, 1])
        let graphN = Graph(canHaveNegativeEdges: false, weights: [-4, 3, 2, -1, -5, 2, 1, 0, 3, 1])
        var solutionSteps: [GraphSolutionStep] = []
        let solutionBFS = BFS().bfs(start: 0, graph: graphP, solutionSteps: &solutionSteps)
        XCTAssert(solutionBFS.0 == [0, 1, 2, 1, 2, 3, 3] && solutionBFS.1 == [0, 0, 1, 0, 3, 2, 2])
        let solutionDijkstra = Dijkstra().dijkstra(start: 0, graph: graphP, solutionSteps: &solutionSteps)
        XCTAssert(solutionDijkstra.0 == [0, 4, 6, 5, 7, 12, 11] && solutionDijkstra.1 == [-1, 0, 1, 0, 3, 6, 2])
        print(solutionDijkstra.0)
        print(solutionDijkstra.1)
        let solutionBellmanFord = BellmanFord().bellmanFord(start: 0, graph: graphN, solutionSteps: &solutionSteps)
        XCTAssert(solutionBellmanFord.0 ==  [0, -4, -2, -3, -3, -7, 0] && solutionBellmanFord.1 == [-1, 0, 1, 2, 3, 2, 2])
    }
}
