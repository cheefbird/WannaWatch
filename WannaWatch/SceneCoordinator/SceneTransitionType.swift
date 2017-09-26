//
//  SceneTransitionType.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/24/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import Foundation


/// Enum representing types of transitions/presentations for View Controllers.
///
/// - root: Sets view controller as the app's root view controller.
/// - push: Push view controller to navigation stack.
/// - modal: Present view controller modally.
enum SceneTransitionType {
  
  case root
  case push
  case modal
  
}
