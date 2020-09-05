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
        
        if let groupColorDic = userDefaults.dictionary(forKey: "groupColor") {
            if let hexColor = groupColorDic["\(groups[indexPath.row].share!)"] as? String {
                cell.groupColorLabelView.backgroundColor = UIColor(hex: hexColor)
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupScheduleListVC = self.storyboard?.instantiateViewController(withIdentifier: "GroupScheduleListVC") as? GroupScheduleListVC else {return}
        groupScheduleListVC.groupKey = groups[indexPath.row].share
        groupScheduleListVC.groupName = groups[indexPath.row].group_name
        groupScheduleListVC.group = groups[indexPath.row]
        let navigation = UINavigationController(rootViewController: groupScheduleListVC)
        navigation.navigationBar.barTintColor = UIColor(displayP3Red: 30/255, green: 177/255, blue: 252/255, alpha: 1)
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SpoqaHanSans-Bold", size: 18)!]
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        print(groupScheduleListVC.groupKey)
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: true, completion: nil)
    }
        
}
