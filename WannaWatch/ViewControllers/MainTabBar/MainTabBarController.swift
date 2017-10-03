//
//  MainTabBarController.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/16/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit
import RealmSwift

class MainTabBarController: UITabBarController {
  
  // MARK: - Properties
  
  var sceneCoordinator: SceneCoordinatorType!
  
  var currentUser: User!
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    delegate = self
    
    currentUser = getCurrentUser()
    
    sceneCoordinator = setupSceneCoordinator()
    
    setupMovieListView()
    
  }
  
  
  // MARK: - Setup on First Load
  
  private func setupMovieListView() {
    
    guard let navController = self.viewControllers?[0] as? UINavigationController else {
      print("TabController Error: Unable to set self.VC's[0] and cast")
      return
    }
    
    guard let movieListVC = navController.childViewControllers.first as? MovieListViewController
      else {
        print("TabController Error: Couldn't set movie list vc using navCtonrollers.children.first")
        return
    }
    
    guard var sceneCoordinator = sceneCoordinator,
      currentUser != nil else {
        print("TabController Error: Unable to set sceneController")
        return
    }
    
    sceneCoordinator.currentViewController = movieListVC
    
    let movieService = MovieService(user: currentUser)
    let movieListVM = MovieListViewViewModel(
      movieService: movieService,
      sceneCoordinator: sceneCoordinator)
    
    movieListVC.viewModel = movieListVM
    print("MovieListVM set")
    
  }
  
  
  fileprivate func setupSceneCoordinator() -> SceneCoordinatorType? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
      let appWindow = appDelegate.window else {
        return nil
    }
    
    return SceneCoordinator(window: appWindow)
    
  }
  
  
  fileprivate func getCurrentUser() -> User {
    let realm = try! Realm()
    return User.currentUser(inRealm: realm)
  }
  
}


// MARK: - Delegate

extension MainTabBarController: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    debugPrint("\(viewController) was selected using tab bar")
    debugPrint(tabBarController.selectedIndex)
  }
  
}
