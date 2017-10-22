//
//  SortingViewController.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/1/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit
import PopupKit

class SortingViewController: UIViewController, SettingsViewDelegate {
    
    @IBOutlet weak var sortingView: SortingView!
    @IBOutlet weak var settingsView: SettingsView!
    @IBOutlet weak var codeView: CodeView!
    @IBOutlet weak var dragView: DragView!
    @IBOutlet weak var dragToBottomConstraint: NSLayoutConstraint!
    
    public var algorithm: SortInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = algorithm.name
        settingsView.pickerData = (0..<NumberOrder.mapper.count).map {
            NumberOrder(rawValue: $0)!.string
        }
        settingsView.delegate = self
        codeView.algorithm = algorithm
        dragView.bottomConstraint = dragToBottomConstraint
        dragView.maxDragY = view.frame.size.height - settingsView.frame.size.height - navigationController!.navigationBar.frame.size.height - tabBarController!.tabBar.frame.size.height - 2 * dragView.frame.size.height - 1
    }
    
    public func pickerDidSelectRow(row: Int) {
        let order = NumberOrder(rawValue: row)!
        var numbers: [Int] = (1...10).map {
            switch order {
            case .random: return Int(1 + arc4random_uniform(10))
            case .sortedUp: return $0
            case .sortedDown: return 11 - $0
            }
        }
        sortingView.stopAnimation()
        sortingView.updateBars(values: numbers)
        sortingView.solutionSteps = algorithm.sort(&numbers)
    }
    
    public func animateAlgorithm(stepByStep: Bool) {
        sortingView.animateAlgorithm(stepByStep: stepByStep)
    }
    
    public func showAlgorithmInfoView() {
        let popup = PopupView(contentView: SortingInfoView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width * 0.9, height: view.frame.size.width), algorithm: algorithm), showType: .bounceIn, dismissType: .bounceOut, maskType: .dimmed, shouldDismissOnBackgroundTouch: true, shouldDismissOnContentTouch: true)
        popup.show()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sortingView.stopAnimation()
    }
}
