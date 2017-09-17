//
//  MoviesTarget.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/12/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import Foundation
import Moya


enum MoviesTarget {
  
  case getMovies(page: Int)
  
}


extension MoviesTarget: TargetType {
  
  var baseURL: URL { return URL(string: "https://api.themoviedb.org/3/")! }
  
  var path: String {
    switch self {
    case .getMovies:
      return "/discover/movie"
    }
  }
  
  
  var method: Moya.Method {
    return .get
  }
  
  
  var sampleData: Data {
    switch self {
    case .getMovies:
      return jsonToSample(fileName: "movies")!
    }
  }
  
  
  var task: Task {
    switch self {
    case .getMovies(let page):
      var params = [String: Any]()
      
      params["api_key"] = "7e6576c1d12633c8fd1eee0cb2e995ed"
      params["include_adult"] = false
      params["include_video"] = false
      params["sort_by"] = "popularity.desc"
      params["page"] = page
      
      return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
  }
  
  
  var headers: [String : String]? {
    return ["Content-Type": "application/json"]
  }
}




extension MoviesTarget {
  
  fileprivate func jsonToSample(fileName: String) -> Data? {
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }
    
    return try! Data(contentsOf: file)
    
  }
  
}












