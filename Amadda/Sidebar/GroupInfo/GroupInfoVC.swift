//
//  GroupInfoVC.swift
//  Amadda
//
//  Created by mong on 2020/09/03.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class GroupInfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var groupNameTextField: UITextField!
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmBtn(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InviteCell") as? GroupInfoCell else {return UITableViewCell()}
        
        let seperator = UIView(frame: CGRect(x: cell.frame.origin.x + 10, y: cell.frame.height - 1, width: cell.frame.width - 20, height: 1))
        seperator.backgroundColor = UIColor(displayP3Red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        
        switch indexPath.row {
        case 0:
            cell.iconimageView.image = UIImage(named: "icon_group")
            cell.textField.placeholder = "초대하기"
            cell.textField.isUserInteractionEnabled = false
            cell.accessoryType = .disclosureIndicator
            cell.addSubview(seperator)
            return cell
        case 1:
            cell.iconimageView.image = UIImage(named: "icon_color")
            cell.textField.placeholder = "그룹 컬러"
            cell.textField.isUserInteractionEnabled = false
            cell.accessoryType = .disclosureIndicator
            cell.addSubview(seperator)
            return cell
        case 2:
            cell.iconimageView.image = UIImage(named: "icon_Memo")
            cell.textField.placeholder = "메모"
            cell.accessoryType = .none
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 0 = invite, 1 = color, 2 = memo
    }
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    
    
}
