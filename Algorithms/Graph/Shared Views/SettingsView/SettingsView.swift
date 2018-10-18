//
//  SettingsView.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/1/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dataTypePicker: UIPickerView!
    public var pickerData: [String]! {
        didSet {
            dataTypePicker.delegate = self
            dataTypePicker.dataSource = self
        }
    }

    public weak var delegate: SettingsViewDelegate! {
        didSet { updateVisualisationView() }
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
        Bundle.main.loadNibNamed("SettingsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        clipsToBounds = true
        layer.cornerRadius = 10
    }

    @IBAction func fastForwardButtonPressed(_ sender: UIButton) {
        delegate.animateAlgorithm(stepByStep: false)
    }

    @IBAction func stepByStepButtonPressed(_ sender: UIButton) {
        delegate.animateAlgorithm(stepByStep: true)
    }

    @IBAction func infoIconPressed(_ sender: UIButton) {
        delegate.showAlgorithmInfoView()
    }

    private func updateVisualisationView() {
        delegate.pickerDidSelectRow(row: dataTypePicker.selectedRow(inComponent: 0))
    }
}

extension SettingsView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pLabel = UILabel()
        pLabel.textAlignment = .center
        pLabel.text = pickerData[row]
        return pLabel
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateVisualisationView()
    }
}
