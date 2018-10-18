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
        styleNavAndTabBar()
    }

    private func styleNavAndTabBar() {
        let white = UIColor.white
        let appleBlue = UIColor(displayP3Red: 14 / 255, green: 122 / 255, blue: 254 / 255, alpha: 0.7)
        let  navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.tintColor = white
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.isTranslucent = false
        navBarAppearance.setBackgroundImage(UIImage(color: appleBlue), for: .default)

        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = white
        tabBarAppearance.unselectedItemTintColor = UIColor.lightGray.withAlphaComponent(0.7)

        let imageWidth: CGFloat = tabBar.frame.size.width / 2 / CGFloat(viewControllers!.count)
        let imageHeight: CGFloat = tabBar.frame.size.height / 2
        let indicatorImage = UIImage(color: appleBlue, size: CGSize(width: imageWidth, height: imageHeight))
        tabBar.selectionIndicatorImage = indicatorImage
        view.backgroundColor = white
        tabBar.frame.size.width = view.frame.width + 4
        tabBar.frame.origin.x = -2
    }
}
