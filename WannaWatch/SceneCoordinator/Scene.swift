//
//  Scene.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/24/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit


enum Scene {
  
  case movieDetail(MovieDetailViewViewModel)
  
}


// MARK: - ViewController

extension Scene {
  
  func viewController() -> UIViewController {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    switch self {
      
    case .movieDetail(let viewModel):
      var vc = storyboard.instantiateViewController(withIdentifier: "MovieDetail") as! MovieDetailViewController
      
      vc.bind(withViewModel: viewModel)
      
      return vc
      
    }
    
  }
  
}







