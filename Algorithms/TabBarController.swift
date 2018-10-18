//
//  TabBarController.swift
//  Algorithms
//
//  Created by Florian Kasten on 17.07.16.
//  Copyright © 2016 Florian Kasten. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appleBlue = UIColor(displayP3Red: 14 / 255, green: 122 / 255, blue: 254 / 255, alpha: 0.7)
        let  navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.tintColor = .white
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.isTranslucent = false
        navBarAppearance.setBackgroundImage(UIImage(color: appleBlue), for: .default)
    }
}
