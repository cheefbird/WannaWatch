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


struct MovieListViewViewModel {
  
  // MARK: - Properties
  
  let movieService: MovieServiceType
  
  
  // MARK: - Init
  
  init(movieService: MovieServiceType) {
    self.movieService = movieService
  }
  
  
  // MARK: - Methods
  
  
  
}

