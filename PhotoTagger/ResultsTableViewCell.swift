//
//  ResultsTableViewCell.swift
//  Recyclable.
//
//  Created by Miriam Hendler on 7/2/16.
//  Copyright © 2016  LLC. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
  @IBOutlet weak var label: UILabel!

  @IBOutlet weak var imageVIew: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
