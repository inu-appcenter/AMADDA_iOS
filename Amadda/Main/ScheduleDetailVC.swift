//
//  ScheduleDetailVC.swift
//  Amadda
//
//  Created by mong on 2020/08/24.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class ScheduleDetailVC: UIViewController {
    var scheduleNumber: Int?
    var schedule: Schedule?
    
    @IBOutlet var scheduleTitle: UITextField!
    
    @IBAction func deleteBtn(_ sender: Any) {
        showAlertController(title: "일정을 삭제하시겠어요?", message: "삭제된 일정은 복원할 수 없습니다.", completionHandler: {(alert) in
            guard let scheduleNumber = self.scheduleNumber else {
                self.showDefaultAlertController()
                return
            }
            NetworkManager().deleteSchedule(number: scheduleNumber)
            self.navigationController?.popViewController(animated: true)
        })
        
    }
    override func viewDidLoad() {
        guard let scheduleTableVC = self.children.last as? AddEventTableVC else {
            let alert = UIAlertController(title: "네트워크 에러", message: "다시 시도해 주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {(alert) in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        setDefaultUI(scheduleTableVC: scheduleTableVC)
    }
    private func setDefaultUI(scheduleTableVC: AddEventTableVC){
        scheduleTitle.text = schedule?.schedule_name
        scheduleTableVC.startLabel.text = schedule?.start
        scheduleTableVC.endLabel.text = schedule?.end
        scheduleTableVC.locationTextField.text = schedule?.location
        scheduleTableVC.memoTextField.text = schedule?.memo
    }
}
