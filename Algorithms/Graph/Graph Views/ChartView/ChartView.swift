//
//  ChartView.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/10/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

class ChartView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var distLabels: [UILabel]!
    @IBOutlet var predLabels: [UILabel]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSelf()
    }
    
    private func initSelf() {
        Bundle.main.loadNibNamed("ChartView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        resetTable()
    }
    
    public func setEntries(dist: [Int], pred: [Int]) {
        guard distLabels.count == dist.count else {
            return
        }
        for i in 0..<dist.count {
            distLabels[i].text = dist[i] == Int.max ? "inf" : String(dist[i])
            predLabels[i].text = pred[i] == -1 ? "-" : String(pred[i])
        }
    }
    
    public func resetTable() {
        distLabels.forEach( { $0.text = "inf" })
        predLabels.forEach( { $0.text = "-" } )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
    }
}
