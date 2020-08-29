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
    var selectedGroupName: String?
    var selectedGroupKey: Int?
    
    @IBOutlet var tableView: UITableView!
    @IBAction func backBtn(_ sender: Any) {
        guard let addShareEventVC = self.navigationController?.viewControllers.first as? AddShareEventVC else {return}
        addShareEventVC.groupName = selectedGroupName
        addShareEventVC.groupKey = selectedGroupKey
        self.navigationController?.popViewController(animated: true)
    }
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShareGroupCell") as? ShareGroupCell else {return UITableViewCell()}
        cell.groupNameLabel.text = groups[indexPath.row].group_name
        cell.selectedGroupKey = groups[indexPath.row].share
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for cell in tableView.visibleCells {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShareGroupCell") as? ShareGroupCell else {return}
            cell.selectImageView.image = UIImage(named: "icon_group_unSelect")
        }
        guard let cell = tableView.cellForRow(at: indexPath) as? ShareGroupCell else {return}
        cell.selectImageView.image = UIImage(named: "icon_group_Select")
        selectedGroupName = cell.groupNameLabel.text
        selectedGroupKey = cell.selectedGroupKey
        print(selectedGroupName)
        print(selectedGroupKey)
    }
    
}
