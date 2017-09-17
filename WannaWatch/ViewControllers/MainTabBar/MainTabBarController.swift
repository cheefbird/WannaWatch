//
//  MainTabBarController.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/14/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.delegate = self
  }
  
}


extension MainTabBarController: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    switch tabBarController.selectedIndex {
    default:
      return
    }
  }
  
}
