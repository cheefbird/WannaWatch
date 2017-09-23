//
//  MainTabBarController.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/16/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setMovieListVM()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  // MARK: - Setup on First Load
  
  private func setMovieListVM() {
    
    guard let navController = self.viewControllers?[0] as? UINavigationController else {
      print("TabController Error: Unable to set self.VC's[0] and cast")
      return
    }
    
    guard let movieListVC = navController.childViewControllers.first as? MovieListViewController
      else {
        print("TabController Error: Couldn't set movie list vc using navCtonrollers.children.first")
        return
    }
    
    let movieListVM = MovieListViewViewModel()
    
    movieListVC.viewModel = movieListVM
    print("MovieListVM set")
    
  }
  
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
  }
}


// MARK: - Delegate

extension MainTabBarController: UITabBarControllerDelegate {
  
  
  
}
