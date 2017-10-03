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


class MovieService: MovieServiceType {
  
  
  let disposeBag = DisposeBag()
  
  
  init() {
    do {
      let realm = try Realm()
      if realm.objects(Movie.self).count == 0 {
        getMovies(forPage: 1)
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
  func toggleFavorite(_ movie: Movie) -> Observable<Movie> {
    let result = withRealm("toggling favorite") { realm -> Observable<Movie> in
      try realm.write {
        movie.isFavorite = !movie.isFavorite
      }
      return .just(movie)
    }
    return result ?? .error(MovieServiceError.toggleFavoriteFailed(movie))
  }
  
  
  @discardableResult
  func getMovies(forPage page: Int) -> Observable<[Movie]> {
    print("\(String(describing: RequestRouter.getMovies(page: page).urlRequest))")
    return RxAlamofire.requestJSON(RequestRouter.getMovies(page: page))
      .map { (_, data) -> [JSON] in
        let json = JSON(data)
        return json["results"].arrayValue
      }
      .map { array in
        return array.map { Movie(fromJSON: $0) }
    }
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
