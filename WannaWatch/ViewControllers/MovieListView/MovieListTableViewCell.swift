//
//  MovieListTableViewCell.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/16/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit


class MovieListTableViewCell: UITableViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  
  
  // MARK: - Configure
  
  func configure(withMovie movie: Movie) {
    titleLabel.text = movie.title
    releaseDateLabel.text = movie.releaseDate
    let percentScore = movie.score * 10
    scoreLabel.text = "Vote score: \(percentScore)"
    posterImageView.image = movie.placeholderImage
    
  }
  
  
  func configureEmpty() {
    titleLabel.text = "Some Super Terrible Movie Name"
    releaseDateLabel.text = "2017-09-07"
    scoreLabel.text = "Vote score: 90.0"
    posterImageView.image = #imageLiteral(resourceName: "placeholder")
  }
  
}
