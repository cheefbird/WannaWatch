//
//  MovieDetailViewViewModel.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/24/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import Foundation
import RxSwift
import Action


class MovieDetailViewViewModel {
  
  // MARK: - Properties
  
  let movieService: MovieServiceType
  let movie: Variable<Movie>
  
  
  let disposeBag = DisposeBag()
  
  
  // MARK: - Initializer
  
  init(movieService: MovieServiceType, movie: Movie) {
    self.movieService = movieService
    self.movie = Variable<Movie>(movie)
  }
  
  deinit {
    print("MovieDetailVM deinitialized")
  }
  
  
  // MARK: - Actions
  
  var toggleFavorite: CocoaAction {
    
    return CocoaAction {
      return self.movieService.toggleFavorite(movie: self.movie.value).map { _ in }
    }
  }
}
