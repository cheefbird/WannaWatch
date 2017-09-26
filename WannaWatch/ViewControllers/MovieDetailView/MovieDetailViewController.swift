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
    
  }
  
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
  }
  
  
  func bindToViewModel() {
    
    viewModel.movie.asObservable()
      .subscribe(onNext: { [weak self] movie in
        self?.backdropImageView.kf.setImage(with: movie.imageUrl(forType: .backdrop))
        self?.posterImageView.kf.setImage(with: movie.imageUrl(forType: .posterMedium))
        }, onDisposed: {
          print("DISPOSING")
      })
      .disposed(by: disposeBag)
    
    
    let movie = viewModel.movie.asDriver()
    
    movie.map { $0.title }
      .drive(titleLabel.rx.text)
      .disposed(by: disposeBag)
    
    movie.map { "Released \($0.releaseDate)"}
      .drive(releaseDateLabel.rx.text)
      .disposed(by: disposeBag)
    
    movie.map { "Avg. Score: \($0.score)" }
      .drive(scoreLabel.rx.text)
      .disposed(by: disposeBag)
    
    movie.map { $0.summary }
      .drive(summaryLabel.rx.text)
      .disposed(by: disposeBag)
    
    favoriteButton.rx.action = viewModel.toggleFavorite
    
  }
  
}
