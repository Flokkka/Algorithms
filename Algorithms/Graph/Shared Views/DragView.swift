//
//  DragView.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/4/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

@IBDesignable class DragView: UIView {
    
    public var bottomConstraint: NSLayoutConstraint?
    public var maxDragY: CGFloat!
    
    private var panGesture = UIPanGestureRecognizer()
    private var minDragY: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSelf()
    }
    
    private func initSelf() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(panGesture)
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: frame.size.height / 2))
        path.addLine(to: CGPoint(x: frame.size.width / 2, y: frame.size.height - 1))
        path.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height / 2))
        path.addLine(to: CGPoint(x: frame.size.width / 2, y: 1))
        path.close()
        UIColor.lightGray.set()
        path.stroke()
    }
    
    @objc private func draggedView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        guard bottomConstraint!.constant - translation.y + 1 > minDragY && bottomConstraint!.constant - translation.y - 1 < maxDragY else {
            sender.setTranslation(CGPoint.zero, in: self)
            return
        }
        bottomConstraint!.constant -= translation.y
        sender.setTranslation(CGPoint.zero, in: self)
    }
}
