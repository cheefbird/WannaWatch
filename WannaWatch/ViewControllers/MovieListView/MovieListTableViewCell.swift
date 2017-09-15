//
//  MovieListTableViewCell.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/12/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet weak var posterImage: UIImageView!
  @IBOutlet weak var movieNameLabel: UILabel!
  @IBOutlet weak var movieSummaryLabel: UILabel!
  
  
  // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
