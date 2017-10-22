//
//  VerticeView.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/6/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

enum VerticeState {
    case unvisited
    case visited
    case current
    case aboutToVisit
}

@IBDesignable class VerticeView: UIView {
    
    private var smallLabel: UILabel!
    private var label: UILabel!
    private var isShowingBothLabels = false
    
    public var verticeState: VerticeState! {
        didSet { backgroundColor = getBackgroundColorForCurrentState() }
    }
    
    @IBInspectable public var name: String! {
        didSet { label.text = name }
    }
    
    @IBInspectable public var nameSmall: String! {
        didSet {
            smallLabel.text = nameSmall
            isShowingBothLabels = nameSmall != ""
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSelf()
    }
    
    private func initSelf() {
        layer.masksToBounds = true
        label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        addSubview(label)
        verticeState = .unvisited
        
        smallLabel = UILabel()
        smallLabel.textColor = UIColor.white
        smallLabel.font = smallLabel.font.withSize(10)
        smallLabel.textAlignment = .center
        addSubview(smallLabel)
    }
    
    private func getBackgroundColorForCurrentState() -> UIColor {
        switch verticeState {
            case .unvisited: return UIColor.blue
            case .visited: return UIColor(rgb: 0x008000)
            case .current: return UIColor.red
            case .aboutToVisit: return UIColor.orange
            default: return UIColor.black
        }
    }
    
    public func setIsStart() {
       drawBorder(color: UIColor.purple)
    }
    
    public func setIsEnd() {
        drawBorder(color: UIColor.black)
    }
    
    public func resetIsStart() {
        layer.borderWidth = 0
    }
    
    private func drawBorder(color: UIColor) {
        layer.borderWidth = 2
        layer.borderColor = color.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
        label.frame = isShowingBothLabels ? CGRect(x: 0, y: 2 + bounds.height / 5, width: bounds.width, height: bounds.height * 4 / 5) : bounds
        smallLabel.frame = CGRect(x: 0, y: 2, width: bounds.width, height: bounds.height / 5)
    }
}
