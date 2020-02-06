//
//  StaticTableVc.swift
//  Amadda
//
//  Created by mong on 2020/02/06.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class StaticTableVC: UITableViewController {
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var endLabel: UILabel!
    
    @IBAction func startDatePicker(_ sender: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .short
        let date = dateformatter.string(from: sender.date)
        startLabel.text = "\(date)"
    }
    
    @IBAction func endDatePicker(_ sender: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .short
        let date = dateformatter.string(from: sender.date)
        endLabel.text = "\(date)"
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                startDatePicker.isHidden = !startDatePicker.isHidden
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    // apple bug fix - some TV lines hide after animation
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }else if indexPath.row == 2 {
                endDatePicker.isHidden = !endDatePicker.isHidden
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    // apple bug fix - some TV lines hide after animation
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                let height: CGFloat = startDatePicker.isHidden ? 0.0 : 200
                return height
            }else if indexPath.row == 3 {
                let height: CGFloat = endDatePicker.isHidden ? 0.0 : 200
                return height
            }
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func viewDidLoad() {
        startDatePicker.isHidden = true
        endDatePicker.isHidden = true
    }
}
