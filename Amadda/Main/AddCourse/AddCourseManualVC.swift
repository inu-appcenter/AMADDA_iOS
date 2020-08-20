//
//  AddCourseManualVC.swift
//  Amadda
//
//  Created by mong on 2020/03/10.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class AddCourseManualVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var courseNameTextField: UITextField!
    @IBOutlet var mainView: UIView!
    
    
    override func viewDidLoad() {
 
    }

    @IBAction func addCourseBtn(_ sender: Any) {
        guard let AddCourseManualTableVC = self.children.last as? AddCourseManualTableVC else {
            print("init AddCourseManualTableVC failure")
            return
        }
        if AddCourseManualTableVC.startTimeLabel.tag >= AddCourseManualTableVC.endTimeLabel.tag {
            showDefaultAlertController(title: "", message: "종료 시간을 확인해 주세요", completionHandler: nil)
            return
        }
        var myCourseArray = [Course]()
        if let data = UserDefaults.standard.value(forKey: "MyCourse") as? Data {
            if let myCourse = try? PropertyListDecoder().decode(Array<Course>.self, from: data){
                myCourseArray = myCourse
            }
        }
        let startTimeArray = AddCourseManualTableVC.startTimeLabel.text!.components(separatedBy: " ")
        
        print(startTimeArray)
        let newCourse = Course(subject: courseNameTextField.text!, prof: "", day: startTimeArray[0].stringToDayValue, startTime: startTimeArray[1] + " " + startTimeArray[2], endTime: AddCourseManualTableVC.endTimeLabel.text!, place: AddCourseManualTableVC.placeTextField.text!)
        myCourseArray.append(newCourse)
        guard let parentVC = self.navigationController?.viewControllers.first as? AddCourseVC else {
            print("## init parentVC Failure")
            return
        }
        parentVC.myCourseArray = myCourseArray
        
        self.navigationController?.popViewController(animated: true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y - keyboardRectangle.height, width: view.frame.width, height: view.frame.height)
            
            UIView.animate(withDuration: 0, animations: {
                self.view.layoutIfNeeded()
                }, completion: { (completion) in
            })
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.view.frame = CGRect(x: view.frame.origin.x, y: 0, width: view.frame.width, height: view.frame.height)
                            
            UIView.animate(withDuration: 0, animations: {
                self.view.layoutIfNeeded()
                }, completion: { (completion) in
            })
        }
    }
}
