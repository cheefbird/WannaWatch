//
//  BindableType.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/23/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit


protocol BindableType {
  
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }
  
  func bindToViewModel()
  
}


extension BindableType where Self: UIViewController {
  
  mutating func bind(withViewModel vm: Self.ViewModelType) {
    viewModel = vm
    loadViewIfNeeded()
    bindToViewModel()
  }
  
}
