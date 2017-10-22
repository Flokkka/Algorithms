//
//  ChildControllerProvider.swift
//  Algorithms
//
//  Created by Florian Kasten on 17.07.16.
//  Copyright © 2016 Florian Kasten. All rights reserved.
//

import UIKit

class ChildControllerProvider {
    
    public class func getControllerArrayFromPList(_ plistName: String) -> [UIViewController] {
        let plistFilePath = Bundle.main.path(forResource: plistName, ofType: "plist")!
        let configurationDictionary = NSDictionary(contentsOfFile: plistFilePath)!
        return controllerArrayFromDictionary(configurationDictionary)
    }
    
    private class func controllerArrayFromDictionary(_ configurationDictionary: NSDictionary) -> [UIViewController] {
        let controllerConfigurations = configurationDictionary["TabBarItems"] as! [[String : String]]
        return controllerConfigurations.map({
            getController($0["Storyboard"]!, title: $0["Title"]!, tabTitle: $0["TabTitle"]!, tabImgName: $0["Image"]!)
        })
    }
    
    private class func getController(_ storyboardName: String, title: String, tabTitle: String, tabImgName: String) -> UIViewController {
        let sb = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let vc = sb.instantiateInitialViewController()
        let tabBarImage = UIImage(named: tabImgName)
        vc?.tabBarItem = UITabBarItem(title: tabTitle, image: tabBarImage, selectedImage: tabBarImage)
        if let vc = vc as? UINavigationController {
            vc.topViewController!.title = title
        }
        return vc!
    }
}

