//
//  MovieListViewViewModel.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/16/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift


class MovieListViewViewModel {
  
  // MARK: - Properties
  
  var status: String {
    didSet {
      debugPrint("MovieListVVM status set to \(status)")
    }
  }
  
  
  // MARK: - Init
  
  init() {
    status = "not ready"
  }
  
  
  // MARK: - Methods
  
  
  
}

