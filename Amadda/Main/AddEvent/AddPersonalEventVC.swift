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
    
    var schedule_name: String!
    var start: String!
    var end: String!
    var location: String!
    var alarm: String!
    var memo: String!
    
    @IBOutlet var scheduleNameTextField: UITextField!
    
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
    
    @IBAction func addBtnPressed(_ sender: Any) {
        guard let AddEventTableVC = self.children.last as? AddEventTableVC else {return}
        schedule_name = self.scheduleNameTextField.text ?? ""
        start = AddEventTableVC.startDateValue ?? ""
        end = AddEventTableVC.endDateValue ?? ""
        location = AddEventTableVC.locationTextField.text ?? ""
        alarm = AddEventTableVC.alarmLabel.text ?? ""
        memo = AddEventTableVC.memoTextField.text ?? "메모"
        
        if start == nil || end == nil || schedule_name == ""{
            showDefaultAlertController(title: "일정 추가 실패", message: "빈칸을 확인하세요", completionHandler: nil)
        }else {
            print("startDate: \(start) ## endDate: \(end)")
            NetworkManager().addSchedule(name: schedule_name, start: start, end: end, location: location, alarm: alarm, share: nil, memo: memo, completion: {(response) in
                guard let response = response else {return}
                if response.success! {
                    self.showDefaultAlertController(title: "추가 완료", message: "일정 추가가 완료되었습니다", completionHandler: {(action) in
                        self.dismiss(animated: true, completion: nil)
                    })
                }else {
                    self.showDefaultAlertController(title: "추가 실패", message: "일정 추가를 실패했습니다", completionHandler: nil)
                }
            })
        }
    }
    
}
