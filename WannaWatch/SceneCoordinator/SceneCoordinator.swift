//
//  SceneCoordinator.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/24/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SceneCoordinator: SceneCoordinatorType {

  
  
  // MARK: - Properties
  
  fileprivate var window: UIWindow
  
  /// Tracks currently displayed view controller. Useful when needing to differentiate between displayed VC and presenting VC, such as a navigation controller.
  fileprivate var currentViewController: UIViewController
  
  
  // MARK: - Initializer
  
  required init(window: UIWindow) {
    self.window = window
    
    currentViewController = window.rootViewController!
  }
  
  
  // MARK: - Static Methods
  
  /// Ensures you are using a ViewController and not a navigation controller.
  ///
  /// - Parameter viewController: Controller to be examined.
  /// - Returns: First view if nav controller, self if not.
  static func actualViewController(for viewController: UIViewController) -> UIViewController {
    
    if let navigationController = viewController as? UINavigationController {
      return navigationController.viewControllers.first!
    } else {
      return viewController
    }
  }
  
  
  // MARK: - Transitions
  
  func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void> {
    let subject = PublishSubject<Void>()
    let viewController = scene.viewController()
    
    switch type {
    case .root:
      currentViewController = SceneCoordinator.actualViewController(for: viewController)
      window.rootViewController = viewController
      subject.onCompleted()
      
    case .push:
      guard let navigationController = currentViewController.navigationController else {
        fatalError("Attempted to push a view controller when no nav controller exists.")
      }
      // 
      
    }
  }
  
  
  func pop(animated: Bool) -> Observable<Void> {
    <#code#>
  }
  
}
