//
//  User.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 10/2/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import Foundation
import RealmSwift


class User: Object {
  
  // MARK: - Properties
  
  dynamic var apiKey = ""
  dynamic var id = 0
  
  // MARK: -
  
  let favoriteMovies = List<Movie>()
  
  
  // MARK: - Init
  
  convenience init(apiKey: String, id: Int) {
    self.init()
    
    self.apiKey = apiKey
    self.id = id
  }
  
  
  // MARK: - Realm Overrides
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  
  // MARK: - Methods
  
  private static func createDefaultUser(inRealm realm: Realm) -> User {
    let user = User(apiKey: "7e6576c1d12633c8fd1eee0cb2e995ed", id: 1)
    try! realm.write {
      realm.add(user)
    }
    return user
  }
  
  
  static func currentUser(inRealm realm: Realm) -> User {
    return realm.object(ofType: User.self, forPrimaryKey: 1) ?? createDefaultUser(inRealm: realm)
  }
  
}
