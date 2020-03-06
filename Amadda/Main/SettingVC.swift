//
//  SettingVC.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/03/05.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

class SettingVC: UITableViewController {

    @IBAction func dismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .singleLine
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.tableView.separatorInset.left = 0
        
        
    }

    // MARK: - Table view data source
    


}
