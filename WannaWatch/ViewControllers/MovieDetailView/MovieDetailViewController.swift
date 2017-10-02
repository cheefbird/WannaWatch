//
//  MovieDetailViewController.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/24/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import Kingfisher


class MovieDetailViewController: UIViewController, BindableType {
  
  
  // MARK: - Outlets
  
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var summaryLabel: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var posterImageView: UIImageView!
  
  
  // MARK: - Properties
  
  var viewModel: MovieDetailViewViewModel!
  
  let disposeBag = DisposeBag()
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = viewModel.movieTitle
    
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    viewModel.sceneCoordinator.currentViewController = navigationController!.viewControllers.first!
  }
  
  
  deinit {
    print("EVENT: MovieDetail view deinitialized")
  }
  
  
  func bindToViewModel() {
    
    backdropImageView.kf.indicatorType = .activity
    backdropImageView.kf.setImage(with: viewModel.backdropImagePath)
    posterImageView.kf.indicatorType = .activity
    posterImageView.kf.setImage(with: viewModel.posterImagePath)
    
    titleLabel.text = viewModel.movieTitle
    releaseDateLabel.text = viewModel.releaseDate
    scoreLabel.text = viewModel.score
    summaryLabel.text = viewModel.summary
    
    viewModel.isFavorite.asDriver()
      .drive(favoriteButton.rx.isSelected)
      .disposed(by: disposeBag)
    
    favoriteButton.rx.action = viewModel.toggleAction
    
    viewModel.toggleAction.executionObservables
      .subscribe(onNext: { [weak self] _ in
        if let result = self?.viewModel.isFavorite.value {
          self?.viewModel.isFavorite.value = !result
        }
        }, onCompleted: { _ in
          print("MovieDetailVM action executionObservables completed")
      })
      .disposed(by: disposeBag)

  }
  
  
}









