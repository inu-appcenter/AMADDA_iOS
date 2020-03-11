//
//  AddEmailCell.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/03/09.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

class AddEmailCell: UITableViewCell {
    
    var delegate: selectColorDelegate?

    @IBAction func addPressed(_ sender: Any) {
        delegate?.add()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
