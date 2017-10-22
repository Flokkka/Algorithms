//
//  Dijkstra.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/7/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

struct Dijkstra: GraphInterface {
    
    public var name: String = "Dijkstra"
    public var worstCasePerformance: String = "O(|E|+|V|log|V|)"
    public var limitations: String = "All weights must be positive."
    
    public func go(start: Int, graph: Graph) -> [GraphSolutionStep] {
        var solutionSteps: [GraphSolutionStep] = []
        _ = dijkstra(start: start, graph: graph, solutionSteps: &solutionSteps)
        return solutionSteps
    }
    
    public func dijkstra(start: Int, graph: Graph, solutionSteps: inout [GraphSolutionStep]) -> ([Int], [Int]) {
        var q: [Int] = graph.getNodes()
        var dist = [Int](repeatElement(Int.max, count: graph.verticesCount))
        var pred = [Int](repeatElement(-1, count: graph.verticesCount))
        dist[start] = 0
        while q.count > 0 {
            var uIndex = 0
            var min = dist[q[uIndex]]
            for i in 0..<q.count {
                if dist[q[i]] < min {
                    min = dist[q[i]]
                    uIndex = i
                }
            }
            if min == Int.max {
                break
            }
            let u = q[uIndex]
            q.remove(at: uIndex)
            solutionSteps.append(GraphSolutionStep(dist: dist, pred: pred, vertice: u))
            for v in graph.getNeighbors(forVertice: u) {
                let alt = dist[u] != Int.max ? dist[u] + graph.getWeight(u, v)! : Int.max
                if alt < dist[v] {
                    dist[v] = alt
                    pred[v] = u
                    solutionSteps.append(GraphSolutionStep(dist: dist, pred: pred, vertice: u))
                }
            }
        }
        return (dist, pred)
    }
}
