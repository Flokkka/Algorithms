//
//  SortingView.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/1/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

class SortingView: UIView {
    
    public var solutionSteps: [SortSolutionStep]!
    
    private var bars: [UIView] = []
    private var barHeightConstraints: [NSLayoutConstraint] = []
    private let barColor = UIColor.blue
    private let highlightColors = [UIColor.red, UIColor.green, UIColor.yellow]
    private var timer: Timer?
    private var maxValue: Int?
    
    public func updateBars(values: [Int]) {
        guard values.count != 0 else {
            return
        }
        if bars.count == 0 {
            setupBars(numberOfBars: values.count)
        }
        if maxValue == nil { maxValue = values.max()! }
        for i in 0..<values.count {
            NSLayoutConstraint.deactivate([barHeightConstraints[i]])
            barHeightConstraints[i] = NSLayoutConstraint(item: bars[i], attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: CGFloat(values[i]) / CGFloat(maxValue!), constant: 0)
            NSLayoutConstraint.activate([barHeightConstraints[i]])
            updateConstraints()
        }
    }
    
    private func setupBars(numberOfBars: Int) {
        let barWidth: CGFloat = frame.size.width / CGFloat(numberOfBars)
        let barColors = [UIColor.blue]
        
        for i in 0..<numberOfBars {
            let bar = UIView(frame: CGRect(x: barWidth * CGFloat(i), y: 0, width: barWidth, height: 0))
            bar.backgroundColor = barColors[i % barColors.count]
            addSubview(bar)
            bars.append(bar)
            
            let heightConstraint = NSLayoutConstraint(item: bar, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.3, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: bar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: barWidth)
            let leadingConstraint = NSLayoutConstraint(item: bar, attribute: .leading, relatedBy: .equal, toItem: i > 0 ? bars[i-1] : self, attribute: i > 0 ? .trailing : .leading, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: bar, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            bar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([heightConstraint, widthConstraint, leadingConstraint, bottomConstraint])
            barHeightConstraints.append(heightConstraint)
        }
    }
    
    private func highlightBars(indices: [Int]) {
        struct Holder {
            static var prevIndices: [Int] = []
        }
        Holder.prevIndices.forEach({
            bars[$0].backgroundColor = barColor
        })
        Holder.prevIndices = []
        for i in 0..<indices.count where indices[i] >= 0 {
            bars[indices[i]].backgroundColor = highlightColors[i % highlightColors.count]
            Holder.prevIndices.append(indices[i])
        }
    }
    
    public func stopAnimation() {
        highlightBars(indices: [])
        maxValue = nil
        timer?.invalidate()
    }
    
    public func animateAlgorithm(stepByStep: Bool) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: !stepByStep, block: { _  in
            guard self.solutionSteps.count > 0 else {
                self.stopAnimation()
                return
            }
            if self.solutionSteps[0].type == .step {
                self.updateBars(values: self.solutionSteps[0].element)
            }
            else if self.solutionSteps[0].type == .indices {
                self.highlightBars(indices: self.solutionSteps[0].element)
            }
            self.solutionSteps.removeFirst()
        })
    }
}
