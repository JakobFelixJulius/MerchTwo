//
//  TabBarController.swift
//  MerchTwo
//
//  Created by Jakob Sudau on 10.10.18.
//  Copyright © 2018 jfjs. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.tabBar.isHidden = false
    }
}
