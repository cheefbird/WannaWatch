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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}


// MARK: - TableView Data Source

extension MovieListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    // TODO: dynamic rows
    return 5
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return UITableViewCell()
    
  }
  
}






