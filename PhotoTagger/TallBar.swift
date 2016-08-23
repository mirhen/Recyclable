//
//  TallBar.swift
//  Recyclable.
//
//  Created by Miriam Hendler on 7/2/16.
//  Copyright © 2016  LLC. All rights reserved.
//

import UIKit



  class TallBar: UINavigationBar {
    override func sizeThatFits(size: CGSize) -> CGSize {
      var size = super.sizeThatFits(size)
      size.height += 20
      return size
    }
  }
