//
//  UIColorExtension.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/4/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: Int) {
        self.init(red: CGFloat((rgb >> 16) & 0xFF) / 255, green: CGFloat((rgb >> 8) & 0xFF) / 255, blue: CGFloat(rgb & 0xFF) / 255, alpha: 1)
    }
}
