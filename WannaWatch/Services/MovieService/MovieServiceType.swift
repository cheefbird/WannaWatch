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
  
  @discardableResult
  func toggleFavorite(_ movie: Movie) -> Observable<Movie>
  
  @discardableResult
  func getMovies(forPage page: Int) -> Observable<[Movie]>
  
  
  func saveMovies(_ movies: [Movie])
  
}


enum MovieServiceError: Error {
  
  case getMoviesFailed
  case toggleFavoriteFailed(Movie)
  
}
