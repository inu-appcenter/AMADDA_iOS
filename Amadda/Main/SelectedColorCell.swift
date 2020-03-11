//
//  SelectedColorCell.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/03/08.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

class SelectedColorCell: UITableViewCell {
    
    var delegate: selectColorDelegate? 

    @IBAction func downPressed(_ sender: Any) {
        print("버튼눌림1")
        delegate?.open()
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
