//
//  GraphViewController.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/6/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit
import PopupKit

class GraphViewController: UIViewController {

    public var graph: Graph!
    public var algorithm: GraphInterface!

    @IBOutlet weak var settingsView: SettingsView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var chartView: ChartView!
    @IBOutlet weak var dragView: DragView!
    @IBOutlet weak var dragToBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var codeView: CodeView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = algorithm.name
        graphView.hideEdgeLabels = algorithm is BFS
        graphView.chartView = chartView
        settingsView.pickerData = (0..<graph.verticesCount).map { String($0) }
        settingsView.delegate = self
        codeView.algorithm = algorithm
        dragView.bottomConstraint = dragToBottomConstraint
    }

    public func animateAlgorithm(stepByStep: Bool) {
        graphView.animateAlgorithm(stepByStep: stepByStep)
    }

    public func showAlgorithmInfoView() {
        let popup = PopupView(contentView: GraphInfoView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width * 0.9, height: view.frame.size.width), algorithm: algorithm), showType: .bounceIn, dismissType: .bounceOut, maskType: .dimmed, shouldDismissOnBackgroundTouch: true, shouldDismissOnContentTouch: true)
        popup.show()
    }
}

extension GraphViewController: SettingsViewDelegate {
    public func pickerDidSelectRow(row: Int) {
        graph.setRandomEdges()
        graphView.startNode = row
        graphView.solutionSteps = algorithm.go(start: row, graph: graph)
        graphView.graph = graph
    }
}
