//
//  MovieService.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/23/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxAlamofire
import RxRealm
import SwiftyJSON


struct MovieService: MovieServiceType {
  
  
  let disposeBag = DisposeBag()
  
  
  init() {
    do {
      let realm = try Realm()
      if realm.objects(Movie.self).count == 0 {
        fetchMovies(forPage: 1)
      }
    } catch let error {
      print("** ERROR in init for Movie Service **")
      print(error.localizedDescription)
    }
  }
  
  
  fileprivate func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
    do {
      let realm = try Realm()
      return try action(realm)
    } catch let error {
      print("Failed \(operation) realm with error: \(error)")
      return nil
    }
  }
  
  
  @discardableResult
  func toggleFavorite(movie: Movie) -> Observable<Movie> {
    let result = withRealm("toggling favorite") { realm -> Observable<Movie> in
      try realm.write {
        movie.isFavorite = !movie.isFavorite
      }
      return .just(movie)
    }
    return result ?? .error(MovieServiceError.toggleFavoriteFailed(movie))
  }
  
  
  @discardableResult
  func fetchMovies(forPage page: Int) -> Observable<[Movie]> {
    var result = [Movie]()
    debugPrint(RequestRouter.getMovies(page: 1).urlRequest?.debugDescription)
    requestJSON(RequestRouter.getMovies(page: page))
      .debug()
      .subscribe(onNext: { (response, data) in
        guard let json = data as? [String: Any] else { return }
        guard let movies = json["results"] as? [[String: Any]] else { return }
        
        let moviesJSON = movies.map { JSON($0) }
        
        let realm = try! Realm()
        try! realm.write {
          for movie in moviesJSON {
            
            let newMovie = Movie(fromJSON: movie)
            realm.add(newMovie, update: true)
            
          }
        }

        
        for movie in moviesJSON {
          let newMovie = Movie(fromJSON: movie)
          result.append(newMovie)
        }
        
      })
      .disposed(by: disposeBag)
    
    
    
    return Observable.just(result)
    
  }
  
  
  func saveMovies(_ movies: [Movie]) {
    let realm = try! Realm()
    try! realm.write {
      for movie in movies {
        realm.add(movie, update: true)
      }
    }
  }
  
}
