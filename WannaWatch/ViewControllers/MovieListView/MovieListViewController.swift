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
import RxRealmDataSources


class MovieListViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: - Properties
  
  let disposeBag = DisposeBag()
  
  var viewModel: MovieListViewViewModel!
  
  
  // MARK: - Life Cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print(RxSwift.Resources.total)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    
    let dataSource = RxTableViewRealmDataSource<Movie>(
      cellIdentifier: "MovieCell",
      cellType: MovieListTableViewCell.self) { (cell, indexPath, movie) in
        cell.configure(withMovie: movie)
        
        if indexPath.row > ((20 * self.viewModel.pagesLoaded.value) - 5) {
          self.viewModel.loadMovies(forPage: self.viewModel.pagesLoaded.value + 1)
        }
    }

    
    // Bind data source to tableView
    viewModel.movies()
      .debug("Movie Results", trimOutput: true)
      .bind(to: tableView.rx.realmChanges(dataSource))
      .disposed(by: disposeBag)

    
    tableView.rx.realmModelSelected(Movie.self)
      .debug("Model Selected", trimOutput: true)
      .subscribe(viewModel.viewDetailsAction.inputs)
      .disposed(by: disposeBag)
    
  }
  
}








