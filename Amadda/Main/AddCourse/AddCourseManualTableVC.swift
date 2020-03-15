//
//  AddCourseManualTableVC.swift
//  Amadda
//
//  Created by mong on 2020/03/10.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class AddCourseManualTableVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var startTimePickerView: UIPickerView!
    @IBOutlet var startTimeLabel: UILabel!
    @IBOutlet var endTimePickerView: UIPickerView!
    @IBOutlet var endTimeLabel: UILabel!
    @IBOutlet var placeTextField: UITextField!
    

    let pickerViewData = [
        ["월", "화", "수", "목", "금"],
        ["오전", "오후"],
        ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
        ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]
    ]
    
    override func viewDidLoad() {
        startTimePickerView.isHidden = true
        startTimePickerView.delegate = self
        startTimePickerView.dataSource = self
        endTimePickerView.isHidden = true
        endTimePickerView.delegate = self
        endTimePickerView.dataSource = self
        
        /// Clear TableView EmptyCell Seperator
        self.tableView.tableFooterView = UIView(frame: CGRect())
        self.tableView.backgroundColor = UIColor.clear
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == endTimePickerView {
            endTimeLabel.text = "\(pickerViewData[1][pickerView.selectedRow(inComponent: 0)] + " " + pickerViewData[2][pickerView.selectedRow(inComponent: 1)] + ":" + pickerViewData[3][pickerView.selectedRow(inComponent: 2)])"
        }else {
            startTimeLabel.text = "\(pickerViewData[0][pickerView.selectedRow(inComponent: 0)] + "요일 " + pickerViewData[1][pickerView.selectedRow(inComponent: 1)] + " " + pickerViewData[2][pickerView.selectedRow(inComponent: 2)] + ":" + pickerViewData[3][pickerView.selectedRow(inComponent: 3)])"
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == endTimePickerView {
            return pickerViewData[component + 1][row]
        }
        return pickerViewData[component][row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == endTimePickerView {
            return 3
        }
        return pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == endTimePickerView {
            return pickerViewData[component + 1].count
        }
        return pickerViewData[component].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                startTimePickerView.isHidden = !startTimePickerView.isHidden
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }else if indexPath.row == 2 {
                endTimePickerView.isHidden = !endTimePickerView.isHidden
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.tableView.beginUpdates()
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.tableView.endUpdates()
                })
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                let height: CGFloat = startTimePickerView.isHidden ? 0.0 : 179
                return height
            }else if indexPath.row == 3 {
                let height: CGFloat = endTimePickerView.isHidden ? 0.0 : 179
                return height
            }
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    @objc func didTapGestureOnScreen(_ sender: UITapGestureRecognizer?){
        placeTextField.resignFirstResponder()
        if let AddCourseManualVC = self.parent as? AddCourseManualVC {
            print("AddCourseManualVC init")
            AddCourseManualVC.courseNameTextField.resignFirstResponder()
        }
    }
}
