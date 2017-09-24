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
  

  func movies() -> Observable<Results<Movie>> {
      let realm = try! Realm()
      let movies = realm.objects(Movie.self)
      return Observable.collection(from: movies)
  }
  

  var movieCount: Int {
    let realm = try! Realm()
    return realm.objects(Movie.self).count
  }
  
  
  // MARK: - Init
  
  init(movieService: MovieServiceType) {
    
    self.movieService = movieService
    
  }
  
  
  // MARK: - Methods
  
  func loadMovies(forPage page: Int) {
    movieService.fetchMovies(forPage: page)
  }
  
}

