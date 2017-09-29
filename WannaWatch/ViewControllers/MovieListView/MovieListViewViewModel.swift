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
import Action


struct MovieListViewViewModel {
  
  // MARK: - Properties
  
  let movieService: MovieServiceType
  
  let sceneCoordinator: SceneCoordinatorType
  
  lazy var movieCount: Int = {
    let realm = try! Realm()
    return realm.objects(Movie.self).count
  }()
  
  
  // MARK: - Init
  
  init(movieService: MovieServiceType, sceneCoordinator: SceneCoordinatorType) {
    self.movieService = movieService
    self.sceneCoordinator = sceneCoordinator
    
    debugPrint(sceneCoordinator.currentViewController.debugDescription)
  }
  
  
  // MARK: - Methods
  
  func loadMovies(forPage page: Int) {
    movieService.fetchMovies(forPage: page)
  }
  
  
  func movies() -> Observable<Results<Movie>> {
    let realm = try! Realm()
    let movies = realm.objects(Movie.self).sorted(byKeyPath: "score", ascending: false)
    return Observable.collection(from: movies, synchronousStart: false)
  }
  
  
  // MARK: - Actions
  
  lazy var viewDetailsAction: Action<Movie, Void> = { this in
    return Action { movie in
      let movieDetailVM = MovieDetailViewViewModel(
        movie: movie,
        action: this.toggleFavorite(movie: movie))
      
      return this.sceneCoordinator.transition(to: Scene.movieDetail(movieDetailVM), type: .push)
    }
  }(self)
  
  
  func toggleFavorite(movie: Movie) -> CocoaAction {
    return CocoaAction {
      return self.movieService.toggleFavorite(movie).map { _ in }
    }
  }
  

  
}










