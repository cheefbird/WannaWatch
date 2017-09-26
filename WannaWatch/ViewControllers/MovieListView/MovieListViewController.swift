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
  
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // Bind data source to tableView
    viewModel.movies()
      .bind(
        to: tableView.rx.items(
          cellIdentifier: "MovieCell",
          cellType: MovieListTableViewCell.self)) { (row, element, cell) in
            
            //            if let count = self?.viewModel.movieCount,
            //              row > (count - 6) {
            //              let page = (count / 20) + 1
            //              self?.viewModel.loadMovies(forPage: page)
            //            }
            
            cell.configure(withMovie: element)
      }
      .disposed(by: disposeBag)
    
    
    // Observe table selection for segue
    tableView.rx.itemSelected.asObservable()
      .flatMap { [weak self] index -> Observable<Movie> in
        guard let strongSelf = self else {
          fatalError("Erro when tapping cell - self doesn't exist!")
        }
        
        return strongSelf.viewModel.movies()
          .map { results in
            return results[index.row]
        }
      }
      .debug()
      .subscribe(onNext: { [weak self] movie in
        self?.performSegue(withIdentifier: "showMovieDetail", sender: movie)
        })
      .disposed(by: disposeBag)
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print(RxSwift.Resources.total)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard var movieDetailVC = segue.destination as? MovieDetailViewController,
      let movie = sender as? Movie else { return }
    
    let movieDetailVM = MovieDetailViewViewModel(movieService: viewModel.movieService, movie: movie)
    
    movieDetailVC.bind(withViewModel: movieDetailVM)
  }
  
}








