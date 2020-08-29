//
//  ShareSelectVC.swift
//  Amadda
//
//  Created by mong on 2020/02/06.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class ShareSelectVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var groups = [Group]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShareGroupCell") as? ShareGroupCell else {return UITableViewCell()}
        cell.groupNameLabel.text = groups[indexPath.row].group_name
        return cell
    }
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        NetworkManager().showGroupList(completion: {(response) in
            print(self.groups)
            if response?.groups != nil {
                self.groups = response?.groups as! [Group]
            }
            self.tableView.reloadData()
        })
    }
}
