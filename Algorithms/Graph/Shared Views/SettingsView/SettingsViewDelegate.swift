//
//  SettingsViewDelegate.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/6/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

protocol SettingsViewDelegate: class {
    func pickerDidSelectRow(row: Int)
    func animateAlgorithm(stepByStep: Bool)
    func showAlgorithmInfoView()
}
