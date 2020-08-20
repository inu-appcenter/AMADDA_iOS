//
//  AddCourseVC.swift
//  Amadda
//
//  Created by mong on 2020/02/06.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit


class AddCourseVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var timeLineStackView: UIStackView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tableViewConstraint: NSLayoutConstraint!
    @IBOutlet var timeLineViewConstraint: NSLayoutConstraint!
    
    var myCourseArray = [Course]()
    
    override func viewDidLoad() {
        /// Fetch Course Data
        if let data = UserDefaults.standard.value(forKey: "MyCourse") as? Data {
            if let myCourse = try? PropertyListDecoder().decode(Array<Course>.self, from: data){
                myCourseArray = myCourse
            }
        }
        
        /// Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = setLayout(collectionView: collectionView, height: timeLineStackView.frame.height)
        
        /// NavigationController Setting
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [ NSAttributedString.Key.font : UIFont(name: "SpoqaHanSans-Bold", size: 16)
        ], for: .normal)
        /// 시간표 API 받아올 수 있을때 까지 tableView 가립니다
        tableViewConstraint.constant = 0
        timeLineViewConstraint.constant = 1000
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidAppear(_ animated: Bool) {
        drawTmpAddCourse(collectionView: collectionView, tmpCourse: myCourseArray)
    }
    override func viewDidDisappear(_ animated: Bool) {
        for view in collectionView.subviews {
            if view.accessibilityIdentifier == "MyCourse" {
                view.removeFromSuperview()
            }
        }
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        showAlertController(title: "", message: "변경 사항을 저장하지 않고 끝내시겠습니까?", completionHandler: {(action) in
            self.dismiss(animated: true, completion: nil)
        })
    }
    @IBAction func doneBtn(_ sender: Any) {
        self.showAlertController(title: "", message: "변경 사항을 저장하시겠습니까?", completionHandler: {(action) in
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.myCourseArray), forKey: "MyCourse")
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return testData.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testData[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeTableCollectionViewCell", for: indexPath) as? TimeTableCollectionViewCell else {return UICollectionViewCell()}
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: 20))
        label.text = "\(testData[indexPath.section][indexPath.row])"
        label.textColor = UIColor.black
        cell.addSubview(label)
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.3
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5.0, height: timeLineStackView.frame.height / CGFloat(14))
    }
}

private func drawTmpAddCourse(collectionView: UICollectionView, tmpCourse: [Course]) {
    for course in tmpCourse{
        if let cell = collectionView.cellForItem(at: [Int(course.day)! - 1, course.startIndexPath]) as? UICollectionViewCell {
            
            let timeTable = UIButton(frame: CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.width, height: -(cell.frame.height * CGFloat(course.courseTime))))
            timeTable.backgroundColor = UIColor.orange
            timeTable.alpha = 0.6
            timeTable.accessibilityIdentifier = "MyCourse"
            
            let eventLabel = UILabel(frame: CGRect(x: 0, y: timeTable.bounds.origin.y, width: timeTable.frame.width, height: timeTable.frame.height / 3))
            eventLabel.text = course.subject
            eventLabel.font = UIFont(name: "SpoqaHanSans-Bold", size: 12)
            eventLabel.textColor = UIColor.white
            eventLabel.lineBreakMode = .byCharWrapping
            eventLabel.numberOfLines = 0
            eventLabel.sizeToFit()
            
            let placeLabel = UILabel(frame: CGRect(x: eventLabel.frame.minX, y: eventLabel.frame.maxY + 5, width: timeTable.frame.width, height: timeTable.frame.height / 3))
            placeLabel.text = course.place
            placeLabel.font = UIFont(name: "SpoqaHanSans-Regular", size: 10)
            placeLabel.textColor = UIColor.white
            placeLabel.lineBreakMode = .byCharWrapping
            placeLabel.numberOfLines = 0
            placeLabel.sizeToFit()
            
            timeTable.addSubview(placeLabel)
            timeTable.addSubview(eventLabel)
            
            collectionView.addSubview(timeTable)
            collectionView.bringSubviewToFront(timeTable)
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 0.0
            
            print("## ADD SUBVIEW BTN DONE")
        }
    }
}
