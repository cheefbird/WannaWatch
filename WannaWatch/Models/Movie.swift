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
  dynamic var isFavorite = false
  
  
  // MARK: - Image Type Enum
  
  enum ImageType {
    case posterSmall
    case posterMedium
    case backdrop
  }
  
  
  // MARK: - Init
  
  convenience init(fromJSON json: JSON) {
    self.init()
    
    title = json["title"].stringValue
    posterPath = json["poster_path"].stringValue
    summary = json["overview"].stringValue
    releaseDate = json["release_date"].stringValue
    id = json["id"].intValue
    backdropPath = json["backdrop_path"].stringValue
    score = json["vote_average"].floatValue
  }
  
  
  // MARK: - Realm Overrides
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  
  // MARK: - Computed Properties
  var placeholderImage: UIImage {
    return #imageLiteral(resourceName: "placeholder")
  }
  
  
  // MARK: - Methods
  
  func formattedReleaseDate() -> Date {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    guard let releaseDate = dateFormatter.date(from: releaseDate) else { return Date() }
    
    return releaseDate
    
  }
  
  
  func imageUrl(forType type: ImageType) -> URL {
    
    let baseUrl = "https://image.tmdb.org/t/p/"
    
    var width = 0
    var path = ""
    
    switch type {
      
    case .posterSmall:
      width = 92
      path = posterPath
      
    case .posterMedium:
      width = 185
      path = posterPath
      
    case .backdrop:
      width = 780
      path = backdropPath
      
    }
    
    let imagePath = "\(baseUrl)w\(width)\(path)"
    
    return URL(string: imagePath)!
    
  }
  
}











