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
    
    @IBAction func timeTablePressed(_ sender: Any) {
        
    }
    
    @IBAction func calendarPressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .singleLine
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.tableView.separatorInset.left = 0
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            
            showAlertController(title: "로그아웃 하시겠어요?", message: "모든 일정 및 기록은 보관됩니다.") { (_) in
                print("로그아웃 처리")
            }
        }
    }


}
