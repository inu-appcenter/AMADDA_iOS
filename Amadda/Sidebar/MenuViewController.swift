//
//  MenuViewController.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/23.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var delegate: HomeViewControllerDelegate?
    var groups = [Group]()
    
    @IBOutlet var tableView: UITableView!
    @IBAction func settingPressed(_ sender: Any) {
        let naviController = self.storyboard?.instantiateViewController(withIdentifier: "navi")
        as! UINavigationController
        self.present(naviController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager().getGroup(completion: {(response) in
//            self.groups = response?.groups
            if response?.groups != nil {
                self.groups = response?.groups as! [Group]
                self.tableView.reloadData()
            }
        })
    }
    
}
    

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupCell
        cell.groupNameLabel.text = groups[indexPath.row].group_name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupScheduleListVC = self.storyboard?.instantiateViewController(withIdentifier: "GroupScheduleListVC") as? GroupScheduleListVC else {return}
        groupScheduleListVC.groupKey = groups[indexPath.row].share
        groupScheduleListVC.groupName = groups[indexPath.row].group_name
        print(groupScheduleListVC.groupKey)
        self.present(groupScheduleListVC, animated: true, completion: nil)
    }
        
}
