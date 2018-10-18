//
//  SortingInfoView.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/3/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

class SortingInfoView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var algorithmNameLabel: UILabel!
    @IBOutlet weak var bestCaseLabel: UILabel!
    @IBOutlet weak var averageCaseLabel: UILabel!
    @IBOutlet weak var worstCaseLabel: UILabel!
    @IBOutlet weak var memoryLabel: UILabel!
    @IBOutlet weak var stableLabel: UILabel!
    @IBOutlet weak var methodLabel: UILabel!

    convenience init(frame: CGRect, algorithm: SortInterface) {
        self.init(frame: frame)
        initSelf()
        setupAlgorithmInfo(algorithm)
    }

    private func initSelf() {
        Bundle.main.loadNibNamed("SortingInfoView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        clipsToBounds = true
        layer.cornerRadius = 20
    }

    private func setupAlgorithmInfo(_ algorithm: SortInterface) {
        algorithmNameLabel.text = algorithm.name
        bestCaseLabel.text = algorithm.bestCase
        averageCaseLabel.text = algorithm.averageCase
        worstCaseLabel.text = algorithm.worstCase
        memoryLabel.text = algorithm.memory
        stableLabel.text = algorithm.stable ? "Yes" : "No"
        methodLabel.text = algorithm.method
    }
}
