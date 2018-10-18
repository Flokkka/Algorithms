//
//  GraphView.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/6/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

class GraphView: UIView {

    public var chartView: ChartView!
    public var solutionSteps: [GraphSolutionStep]!
    public var hideEdgeLabels = false

    public var startNode: Int = 0 {
        willSet { verticeViews[startNode].resetIsStart() }
        didSet {
            verticeViews[startNode].setIsStart()
            resetGraph()
            timer?.invalidate()
        }
    }

    public var graph: Graph! {
        didSet {
            setupVerticesConnectors()
            if !hideEdgeLabels {
                setupEdgeLabels()
                updateWeights()
                updateEdgeLabelPositions()
            }
            resetGraph()
            layoutIfNeeded()
        }
    }

    private var edgesLabels: [UILabel] = []
    private var selectedEdges: [(Int, Int)] = []
    private var currentEdge: Int?
    private var verticesConnectors: [(VerticeView, VerticeView)]?
    private var lastCurrentVertice: Int?
    private var timer: Timer?

    @IBOutlet var contentView: UIView!
    @IBOutlet var verticeViews: [VerticeView]!
    @IBOutlet weak var negativeWeightCycleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSelf()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSelf()
    }

    private func initSelf() {
        Bundle.main.loadNibNamed("GraphView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    private func setupVerticesConnectors() {
        verticesConnectors = (0..<verticeViews.count).flatMap { i in
            graph.getNeighbors(forVertice: i).map { j in
                (verticeViews[i], verticeViews[j])
            }
        }
    }

    private func setupEdgeLabels() {
        edgesLabels.forEach { $0.removeFromSuperview() }
        edgesLabels = []
        (0..<graph.edgesCount).forEach { _ in
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
            label.textAlignment = .center
            label.font = label.font.withSize(12)
            contentView.addSubview(label)
            edgesLabels.append(label)
        }
    }

    override func draw(_ rect: CGRect) {
        guard let verticesConnectors = verticesConnectors else {
            return
        }
        var i = 0
        for vc in verticesConnectors {
            //calculate a and b (x and y) of small triangle inside big triangle
            let a = vc.1.center.x - vc.0.center.x
            let b = vc.1.center.y - vc.0.center.y
            let c: CGFloat = sqrt(a*a + b*b)
            let r = vc.0.frame.size.width / 2
            let x: CGFloat = a * r / c
            let y: CGFloat = b * r / c

            //connect
            let path = UIBezierPath()
            path.move(to: CGPoint(x: vc.0.center.x + x, y: vc.0.center.y + y))
            let dest = CGPoint(x: vc.1.center.x - x, y: vc.1.center.y - y)
            path.addLine(to: dest)

            //draw arrow
            let start: CGPoint = CGPoint(x: dest.x - x / 2, y: dest.y - y / 2)
            let v: CGPoint = CGPoint(x: dest.x - start.x, y: dest.y - start.y)
            let p = sqrt(v.x * v.x + v.y * v.y)
            let h = r / 4
            path.move(to: dest)
            path.addLine(to: CGPoint(x: start.x + -v.y / p * h, y: start.y + v.x / p * h))
            path.move(to: dest)
            path.addLine(to: CGPoint(x: start.x + -v.y / p * -h, y: start.y + v.x / p * -h))

            path.close()
            currentEdge != nil && i == currentEdge ? UIColor.red.set() : UIColor.black.set()
            path.stroke()
            i += 1
        }
    }

    private func updateEdgeLabelPositions() {
        guard !edgesLabels.isEmpty else {
            return
        }
        var i = 0
        for v in graph.getNodes() {
            for w in graph.getNeighbors(forVertice: v) {
                let start = verticeViews[v].center
                let end = verticeViews[w].center
                let middle = CGPoint(x: start.x + (end.x - start.x) / 2, y: start.y + (end.y - start.y) / 2)
                let v: CGPoint = CGPoint(x: middle.x - start.x, y: middle.y - start.y)
                let p = sqrt(v.x * v.x + v.y * v.y)
                let h: CGFloat = 10
                let labelCenter = CGPoint(x: middle.x + -v.y / p * -h, y: middle.y + v.x / p * -h)
                edgesLabels[i].center = labelCenter
                i += 1
            }
        }
    }

    private func updateWeights() {
        guard !edgesLabels.isEmpty else {
            return
        }
        var i = 0
        for v in graph.getNodes() {
            for w in graph.getNeighbors(forVertice: v) {
                let weight = graph.getWeight(v, w)!
                edgesLabels[i].text = String(weight)
                i += 1
            }
        }
    }

    private func resetGraph() {
        verticeViews.forEach {
            $0.verticeState = .unvisited
            $0.nameSmall = ""
            lastCurrentVertice = nil
            currentEdge = nil
            selectedEdges = []
            negativeWeightCycleLabel.isHidden = true
        }
        chartView.resetTable()
    }

    public func animateAlgorithm(stepByStep: Bool) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: !stepByStep, block: { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            guard !self.solutionSteps.isEmpty else {
                if let lastCurrentVertice = self.lastCurrentVertice {
                    self.verticeViews[lastCurrentVertice].verticeState = .visited
                    self.setNeedsDisplay()
                }
                self.timer?.invalidate()
                return
            }
            let solutionStep = self.solutionSteps[0]
            solutionStep.successors.forEach {
                self.verticeViews[$0].verticeState = .aboutToVisit
            }
            (0..<solutionStep.dist.count).forEach {
                self.verticeViews[$0].nameSmall = solutionStep.dist[$0] != Int.max ? String(solutionStep.dist[$0]) : ""
            }
            if let vertice = solutionStep.vertice {
                self.verticeViews[vertice].verticeState = .current
            }
            if let lastCurrentVertice = self.lastCurrentVertice, lastCurrentVertice != solutionStep.vertice {
                self.verticeViews[lastCurrentVertice].verticeState = .visited
            }
            self.lastCurrentVertice = solutionStep.vertice
            self.currentEdge = solutionStep.edge
            self.negativeWeightCycleLabel.isHidden = !solutionStep.negativeWeightCycle
            self.chartView.setEntries(dist: solutionStep.dist, pred: solutionStep.pred)
            self.solutionSteps.removeFirst()
            self.setNeedsDisplay()
        })
    }

    private func updateAlpha() {
        let verticeViewHeight = verticeViews[0].frame.height
        alpha = (frame.height - verticeViewHeight / 2) / verticeViewHeight / 4
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
        setNeedsDisplay()
        if !hideEdgeLabels {
            updateEdgeLabelPositions()
        }
        updateAlpha()
    }
}
