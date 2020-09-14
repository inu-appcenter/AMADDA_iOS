//
//  GroupMemberVC.swift
//  Amadda
//
//  Created by mong on 2020/09/04.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class GroupMemberVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var share: Int?
    var members = [Member]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        guard let GroupInfoVC = self.navigationController?.viewControllers[1] as? GroupInfoVC else {return}
        self.share = GroupInfoVC.group?.share
    }
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager().showGroupMember(share: share, completion: {(response) in
            if let members = response?.members {
                self.members = members
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell") as? MemberCell else {return UITableViewCell()}
        
        if let path = members[indexPath.row].path {
            if let url = URL(string: path) {
            if let imageData = try? Data(contentsOf: url) {
                let image = UIImage(data: imageData)
                cell.profileImageView.image = image
            }
            }
        }
        cell.hakbunLabel.text = members[indexPath.row].id
        cell.nameLabel.text = members[indexPath.row].name
        
        return cell
    }
    
}
