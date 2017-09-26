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
  
  
  /// Perform scene transition. On successful transition, resulting observable completes. Can be subscribed to if you want to take further action, as it works like a completion callback.
  ///
  /// - Parameters:
  ///   - scene: Destination scene for transition.
  ///   - type: Type of transition to perform. Only use push when calling from view with UINavigationController
  /// - Returns: Void/empty Observable that doesn't emit anything and completes when transition is completed.
  @discardableResult
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
      
      // Intercept navigationController(_:didShow:animated:) delegate message and emit when new VC is pushed
      _ = navigationController.rx.delegate
        .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
        .map { _ in }
        .bind(to: subject)
      // Push the new controller and trigger the previous observable
      navigationController.pushViewController(viewController, animated: true)
      currentViewController = SceneCoordinator.actualViewController(for: viewController)
      
    case .modal:
      currentViewController.present(viewController, animated: true) {
        subject.onCompleted()
      }
      currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
    
    return subject.asObservable()
      .take(1)
      .ignoreElements()
  }
  
  
  
  /// Perform backwards transition. Dismisses modals and pops controllers from nav stack.
  ///
  /// - Parameter animated: Perform animation when transitioning.
  /// - Returns: Void/empty Observable that doesn't emit anything and completes when transition is completed.
  @discardableResult
  func pop(animated: Bool) -> Observable<Void> {
    let subject = PublishSubject<Void>()
    
    // Dismiss scene presented modally.
    if let presenter = currentViewController.presentingViewController {
      currentViewController.dismiss(animated: animated) {
        
        self.currentViewController = SceneCoordinator.actualViewController(for: presenter)
        subject.onCompleted()
      }
      // Pop scene from navigation stack.
    } else if let navigationController = currentViewController.navigationController {
      
      _ = navigationController.rx.delegate
        .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
        .map { _ in }
        .bind(to: subject)
      
      guard navigationController.popViewController(animated: animated) != nil else {
        fatalError("Failed to pop \(self.currentViewController) from \(navigationController)")
      }
      
      currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
    } else {
      // View controller has nothing to Pop
      fatalError("SceneCoordinator.pop(animated:) had nothing to pop when called from \(currentViewController)")
    }
    
    return subject.asObservable()
      .take(1)
      .ignoreElements()
    
  }
  
}














