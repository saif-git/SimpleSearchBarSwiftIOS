//
//  TableCell.swift
//  SearchBarTableView
//
//  Created by user on 18/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var nameLa: UILabel!
    @IBOutlet weak var categoryLa: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
