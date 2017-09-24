//
//  MovieListViewController.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/16/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm


class MovieListViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: - Properties
  
  let disposeBag = DisposeBag()
  
  var viewModel: MovieListViewViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.movies()
      .bind(
        to: tableView.rx.items(
          cellIdentifier: "MovieCell",
          cellType: MovieListTableViewCell.self)) { [weak self] (row, element, cell) in
            
//            if let count = self?.viewModel.movieCount,
//              row > (count - 6) {
//              let page = (count / 25) + 1
//              self?.viewModel.loadMovies(forPage: page)
//            }

            cell.configure(withMovie: element)
      }
      .disposed(by: disposeBag)
    
  }
}








