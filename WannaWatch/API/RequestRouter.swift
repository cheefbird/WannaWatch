//
//  RequestRouter.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/16/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import Foundation
import Alamofire


enum RequestRouter: URLRequestConvertible {
  
  
  case getMovies(page: Int)
  
  
  
  private var apiKey: String {
    return "7e6576c1d12633c8fd1eee0cb2e995ed"
  }
  
  
  var baseURL: URL {
    return URL(string: "https://api.themoviedb.org/3/")!
  }
  
  
  var path: String {
    switch self {
    case .getMovies:
      return "discover/movie"
    }
  }
  
  
  var method: HTTPMethod {
    return .get
  }
  
  
  var parameters: Parameters {
    var params = Parameters()
    params["api_key"] = apiKey
    params["sorty_by"] = "vote_average.desc"
    params["vote_count.gte"] = 1000
    params["include_adult"] = "false"
    params["include_video"] = "false"
    
    switch self {
    case .getMovies(let page):
      params["page"] = page
    }
    
    return params
    
  }
  
  
  func asURLRequest() throws -> URLRequest {
    
    let requestURL = baseURL.appendingPathComponent(path)
    
    var request = URLRequest(url: requestURL)
    request.httpMethod = method.rawValue
    
    let encoding = URLEncoding.default
    
    return try! encoding.encode(request, with: parameters)
    
  }
}
