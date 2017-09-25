//
//  CustomButton.swift
//  WannaWatch
//
//  Created by Francis Breidenbach on 9/24/17.
//  Copyright © 2017 Francis Breidenbach. All rights reserved.
//

import UIKit


@IBDesignable class CustomButton: UIButton {
  
  @IBInspectable var borderColor: UIColor = UIColor.white {
    didSet {
      layer.borderColor = borderColor.cgColor
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 2.0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var cornerRadius: CGFloat = 1.0 {
    didSet {
      layer.cornerRadius = cornerRadius
    }
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    clipsToBounds = true
  }
}
