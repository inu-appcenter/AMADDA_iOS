//
//  StaticTableVc.swift
//  Amadda
//
//  Created by mong on 2020/02/06.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit


class AddEventTableVC: UITableViewController {
    
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    @IBOutlet var alarmDatePicker: UIDatePicker!
    
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var endLabel: UILabel!
    @IBOutlet var alarmLabel: UILabel!
    @IBOutlet var shareLabel: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
    var flag: Bool = false
    var startDateValue: String?
    var endDateValue: String?
    
    override func viewDidLoad() {
        startDatePicker.isHidden = true
        endDatePicker.isHidden = true
        alarmDatePicker.isHidden = true
        self.tableView.tableFooterView = UIView(frame: CGRect())
        self.tableView.backgroundColor = UIColor.clear
    }
    
    @IBAction func startDatePicker(_ sender: UIDatePicker) {
        let dateformatter = CustomDateFormatter(dateStyle: .medium, timeStyle: .short)
        let date = dateformatter.string(from: sender.date)
        
        startDateValue = CustomDateFormatter().string(from: sender.date)
        startLabel.text = "\(date)"
        startLabel.textColor = UIColor.textGray
    }
    
    @IBAction func endDatePicker(_ sender: UIDatePicker) {
        let dateformatter = CustomDateFormatter(dateStyle: .none, timeStyle: .short)
        let date = dateformatter.string(from: sender.date)
        
        endDateValue = CustomDateFormatter().string(from: sender.date)
        endLabel.text = "\(date)"
        endLabel.textColor = UIColor.textGray
    }
    @IBAction func alarmDatePicker(_ sender: UIDatePicker) {
        let dateformatter = CustomDateFormatter(dateStyle: .none, timeStyle: .short)
        let date = dateformatter.string(from: sender.date)
        
        alarmLabel.text = "\(date)"
        alarmLabel.textColor = UIColor.textGray
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                startDatePicker.isHidden = !startDatePicker.isHidden
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }else if indexPath.row == 2 {
                endDatePicker.isHidden = !endDatePicker.isHidden
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }else if indexPath.row == 5 {
                alarmDatePicker.isHidden = !alarmDatePicker.isHidden
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }else if tableView.cellForRow(at: indexPath)?.reuseIdentifier == "share"{
                print("share!")
                guard let ShareSelectVC = self.storyboard?.instantiateViewController(withIdentifier: "ShareSelectVC") as? ShareSelectVC else {return}
                self.parent?.navigationController?.pushViewController(ShareSelectVC, animated: true)
                
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
            }else if indexPath.row == 6 {
                let height: CGFloat = alarmDatePicker.isHidden ? 0.0 : 200
                return height
            }else if indexPath.row == 7 {
                if flag {return 0.0}
            }
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}
