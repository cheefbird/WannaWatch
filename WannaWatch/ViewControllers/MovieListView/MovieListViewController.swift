//
//  MovieListViewController.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/16/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: - Properties
  
  var viewModel: MovieListViewViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(self.viewModel.status)
    
  }
}


// MARK: - TableView Data Source

extension MovieListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    // TODO: dynamic rows
    return 5
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieListTableViewCell
    
    cell.configureEmpty()
    
    return cell
    
  }
  
}






