//
//  BellmanFord.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/9/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

struct BellmanFord: GraphInterface {

    public var name = "Bellman-Ford"
    public var worstCasePerformance = "Θ(|V||E|)"
    public var limitations = "None."

    public func go(start: Int, graph: Graph) -> [GraphSolutionStep] {
        var solutionSteps: [GraphSolutionStep] = []
        _ = bellmanFord(start: start, graph: graph, solutionSteps: &solutionSteps)
        return solutionSteps
    }

    public func bellmanFord(start: Int, graph: Graph, solutionSteps: inout [GraphSolutionStep]) -> ([Int], [Int]) {
        var dist = [Int](repeatElement(Int.max, count: graph.verticesCount))
        var pred = [Int](repeatElement(-1, count: graph.verticesCount))
        dist[start] = 0

        for _ in 0..<graph.verticesCount {
            var i = 0
            for u in graph.getNodes() {
                for v in graph.getNeighbors(forVertice: u) {
                    let weight = graph.getWeight(u, v)!
                    solutionSteps.append(GraphSolutionStep(dist: dist, pred: pred, edge: i))
                    if dist[u] != Int.max && dist[u] + weight < dist[v] {
                        dist[v] = dist[u] + weight
                        pred[v] = u
                    }
                    solutionSteps.append(GraphSolutionStep(dist: dist, pred: pred))
                    i += 1
                }
            }
        }
        //negative edge cycle
        for u in graph.getNodes() {
            for v in graph.getNeighbors(forVertice: u) {
                let weight = graph.getWeight(u, v)!
                if dist[u] != Int.max && dist[u] + weight < dist[v] {
                    solutionSteps.append(GraphSolutionStep(dist: dist, pred: pred, negativeWeightCycle: true))
                    return (dist, pred)
                }
            }
        }
        return (dist, pred)
    }
}
