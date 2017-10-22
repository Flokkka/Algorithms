//
//  BFS.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/7/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

struct BFS: GraphInterface {
    
    public var name: String = "BFS"
    public var worstCasePerformance: String = "O(|V|+|E|)"
    public var limitations: String = "All weights must be 1."
    
    public func go(start: Int, graph: Graph) -> [GraphSolutionStep] {
        var solutionSteps: [GraphSolutionStep] = []
        _ = bfs(start: start, graph: graph, solutionSteps: &solutionSteps)
        return solutionSteps
    }
    
    public func bfs(start: Int, graph: Graph, solutionSteps: inout [GraphSolutionStep]) -> ([Int], [Int]) {
        var dist = [Int](repeating: Int.max, count: graph.verticesCount)
        var pred = [Int](repeating: -1, count: graph.verticesCount)
        var q: [Int] = []
        dist[start] = 0
        pred[start] = start
        q.append(start)
        while q.count > 0 {
            let u = q[0]
            q.removeFirst()
            solutionSteps.append(GraphSolutionStep(dist: dist, pred: pred, successors: [], vertice: u))
            var validNeighbors: [Int] = []
            for v in graph.getNeighbors(forVertice: u) where pred[v] == -1 {
                q.append(v)
                validNeighbors.append(v)
                dist[v] = dist[u] + 1
                pred[v] = u
            }
            if validNeighbors.count > 0 {
                solutionSteps.append(GraphSolutionStep(dist: dist, pred: pred, successors: validNeighbors, vertice: u))
            }
        }
        return (dist, pred)
    }
}
