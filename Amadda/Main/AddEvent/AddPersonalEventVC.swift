//
//  AddPersonalEventVC.swift
//  Amadda
//
//  Created by mong on 2020/02/06.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class AddPersonalEventVC: UIViewController {
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "personalSegue" {
            guard let AddEventTableVC = segue.destination as? AddEventTableVC else {return}
//            AddEventTableVC.tableView.cellForRow(at: IndexPath(row: 7, section: 0))?.isHidden = true
            AddEventTableVC.flag = true
        }
    }
}
