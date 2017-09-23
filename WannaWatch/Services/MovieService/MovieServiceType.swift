//
//  MovieServiceType.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/23/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift


protocol MovieServiceType {
  
  func movies() -> Observable<Results<Movie>>
  
  @discardableResult
  func toggleFavorite(movie: Movie) -> Observable<Movie>
  
  @discardableResult
  func fetchMovies(forPage page: Int) -> Observable<[Movie]>
  
  
  func saveMovies(_ movies: [Movie])
  
}


enum MovieServiceError: Error {
  
  case toggleFavoriteFailed(Movie)
  
}
