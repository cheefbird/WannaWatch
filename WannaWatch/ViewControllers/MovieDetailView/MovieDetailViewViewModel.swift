//
//  MovieDetailViewViewModel.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/24/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import Foundation
import RxSwift
import Action


class MovieDetailViewViewModel {
  
  // MARK: - Properties
  
  let backdropImagePath: URL
  let posterImagePath: URL
  let movieTitle: String
  let releaseDate: String
  let score: String
  let summary: String
  
  let toggleAction: CocoaAction
  
  let isFavorite: Variable<Bool>
    
  var sceneCoordinator: SceneCoordinatorType
  
  
  // MARK: - Initializer
  
  init(movie: Movie, coordinator: SceneCoordinatorType, action: CocoaAction) {
    
    backdropImagePath = movie.imageUrl(forType: .backdrop)
    posterImagePath = movie.imageUrl(forType: .posterMedium)
    movieTitle = movie.title
    releaseDate = "Released: \(movie.formattedReleaseDate().description)"
    score = "Avg. Score: \(movie.score)"
    summary = movie.summary
    
    toggleAction = action
    
    isFavorite = Variable<Bool>(movie.isFavorite)
    
    sceneCoordinator = coordinator
    
  }
}
