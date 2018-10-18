//
//  GraphInfoView.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/7/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

class GraphInfoView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var algorithmNameLabel: UILabel!
    @IBOutlet weak var worstCasePerformanceLabel: UILabel!
    @IBOutlet weak var limitationsLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSelf()
    }

    init(frame: CGRect, algorithm: GraphInterface) {
        super.init(frame: frame)
        initSelf()
        setupAlgorithmInfo(algorithm)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSelf()
    }

    private func initSelf() {
        Bundle.main.loadNibNamed("GraphInfoView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        clipsToBounds = true
        layer.cornerRadius = 20
    }

    private func setupAlgorithmInfo(_ algorithm: GraphInterface) {
        algorithmNameLabel.text = algorithm.name
        worstCasePerformanceLabel.text = algorithm.worstCasePerformance
        limitationsLabel.text = algorithm.limitations
    }
}
