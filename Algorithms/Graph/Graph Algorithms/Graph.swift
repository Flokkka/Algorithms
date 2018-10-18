//
//  Graph.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/6/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

class Graph {

    public var verticesCount: Int {
        return neighborPointers.count
    }
    public var edgesCount: Int {
        return neighbors.count
    }

    private var neighborPointers: [Int]
    private var neighbors: [Int]
    private var weights: [Int]?
    private var canHaveNegativeEdges = false

    init(canHaveNegativeEdges: Bool = false) {
        neighborPointers = [0, 2, 3, 6, 8, 9, 9]
        neighbors = [1, 3, 2, 3, 5, 6, 1, 4, 2, 5]
        self.canHaveNegativeEdges = canHaveNegativeEdges
        setRandomEdges()
    }

    convenience init(canHaveNegativeEdges: Bool, weights: [Int]) {
        self.init(canHaveNegativeEdges: canHaveNegativeEdges)
        self.weights = weights
    }

    public func setRandomEdges() {
        weights = (1...10).map { _ in
            Int(1 + arc4random_uniform(10)) - (canHaveNegativeEdges ? 5 : 0)
        }
    }

    public func getNeighbors(forVertice vertice: Int) -> [Int] {
        guard vertice < neighborPointers.count else {
            return []
        }
        let startIndex = neighborPointers[vertice]
        let endIndex = vertice + 1 < neighborPointers.count ? neighborPointers[vertice + 1] : neighbors.count
        return Array(neighbors[startIndex..<endIndex])
    }

    public func getNodes() -> [Int] {
        return Array(0..<neighborPointers.count)
    }

    public func getWeight(_ v: Int, _ w: Int) -> Int? {
        guard let weights = weights else {
            return nil
        }
        for i in 0..<getNeighbors(forVertice: v).count {
            let neighborsIndex = neighborPointers[v] + i
            if neighbors[neighborsIndex] == w {
                return weights[neighborsIndex]
            }
        }
        return nil
    }
}
