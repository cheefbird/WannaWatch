//
//  SceneCoordinatorType.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/24/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit
import RxSwift


protocol SceneCoordinatorType {
  
  init(window: UIWindow)
  
  var currentViewController: UIViewController { get set }
  
  @discardableResult
  func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void>
  
  @discardableResult
  func pop(animated: Bool) -> Observable<Void>
  
}


extension SceneCoordinatorType {
  
  @discardableResult
  func pop() -> Observable<Void> {
    return pop(animated: true)
  }
  
}
