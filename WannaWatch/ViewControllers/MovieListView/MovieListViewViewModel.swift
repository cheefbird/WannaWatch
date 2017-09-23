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
import RxRealm


struct MovieListViewViewModel {
  
  // MARK: - Properties
  
  let movieService: MovieServiceType
  
  var movies: Observable<[Movie]> {
    return movieService.movies()
      .map { results in
        return results.toArray()
    }
  }
  
  
  // MARK: - Init
  
  init(movieService: MovieServiceType) {
    self.movieService = movieService
  }
  
  
  // MARK: - Methods
  
  
  
}

