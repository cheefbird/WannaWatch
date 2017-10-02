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
  
  let disposeBag = DisposeBag()
  
  
  // MARK: - Observables
  
  let pagesLoaded = Variable<Int>(1)
  
  let isLoading = Variable<Bool>(false)
  
  
  // MARK: - Init
  
  init(movieService: MovieServiceType, sceneCoordinator: SceneCoordinatorType) {
    self.movieService = movieService
    self.sceneCoordinator = sceneCoordinator
    
    loadMovies(forPage: 1)
    debugPrint(sceneCoordinator.currentViewController.debugDescription)
  }
  
  
  // MARK: - Methods
  
  func loadMovies(forPage page: Int) {
    movieService.getMovies(forPage: page)
      .observeOn(SerialDispatchQueueScheduler(qos: .background))
      .do(onNext: { _ in
        self.pagesLoaded.value = page
        print("PAGES LOADED: \(self.pagesLoaded.value)")
      })
      .subscribe(Realm.rx.add(update: true))
      .disposed(by: disposeBag)
  }
  
  
  func movies() -> Observable<(AnyRealmCollection<Movie>, RealmChangeset?)> {
    let realm = try! Realm()
    let movies = realm.objects(Movie.self).sorted(byKeyPath: "score", ascending: false)
    return Observable.changeset(from: movies)
  }
  
  
  // MARK: - Actions
  
  lazy var viewDetailsAction: Action<Movie, Void> = { this in
    return Action { movie in
      let movieDetailVM = MovieDetailViewViewModel(
        movie: movie,
        coordinator: this.sceneCoordinator,
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










