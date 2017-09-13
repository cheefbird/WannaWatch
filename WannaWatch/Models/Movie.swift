//
//  Movie.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/12/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON


class Movie: Object {
  
  // MARK: - Properties
  
  dynamic var title = ""
  dynamic var posterPath = ""
  dynamic var summary = ""
  dynamic var releaseDate = ""
  dynamic var id = 0
  dynamic var backdropPath = ""
  dynamic var score: Float = 0.0
  
  
  // MARK: - Init
  
  convenience init(fromJSON json: JSON) {
    self.init()
    
    title = json["title"].stringValue
    posterPath = json["poster_path"].stringValue
    summary = json["overview"].stringValue
    releaseDate = json["release_date"].stringValue
    id = json["id"].intValue
    backdropPath = json["backdrop_path"].stringValue
    score = json["popularity"].floatValue
  }
  
  
  // MARK: - Overrides
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  
  // MARK: - Computed Properties
  
  
  
  // MARK: - Methods
  
  func formattedReleaseDate(_ date: String) -> Date {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    guard let releaseDate = dateFormatter.date(from: date) else { return Date() }
    
    return releaseDate
    
  }
  
}
