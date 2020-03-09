//
//  SearchCourseTableVC.swift
//  Amadda
//
//  Created by mong on 2020/02/26.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class SearchCourseTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var searchTextField: UITextField!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapGestureOnScreen(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AddCourseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddCourseTableViewCell") as? AddCourseTableViewCell else {return UITableViewCell()}
        
        cell.typeLabel.text = courseType[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            tableViewBottomConstraint.constant = -keyboardRectangle.height
            
            UIView.animate(withDuration: 0, animations: {
                self.view.layoutIfNeeded()
                }, completion: { (completion) in
            })
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            tableViewBottomConstraint.constant = 0
                            
            UIView.animate(withDuration: 0, animations: {
                self.view.layoutIfNeeded()
                }, completion: { (completion) in
            })
        }
    }
    @objc func didTapGestureOnScreen(_ sender: UITapGestureRecognizer?){
        searchTextField.resignFirstResponder()
    }
}
