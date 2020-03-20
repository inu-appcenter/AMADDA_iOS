//
//  Function.swift
//  Amadda
//
//  Created by mong on 2020/03/19.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

/// 직접 추가한 일정을 불러와서 collectionView에 UI를 그립니다
func drawManualEvent(collectionView: UICollectionView, gesture: UITapGestureRecognizer) {
    if let data = UserDefaults.standard.value(forKey: "MyCourse") as? Data {
        if let myCourse = try? PropertyListDecoder().decode(Array<Course>.self, from: data){
            print(myCourse)
            for course in myCourse{
                if let cell = collectionView.cellForItem(at: [Int(course.day)! - 1, 3]) as? UICollectionViewCell {
                    let timeTable = UIView(frame: CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.width, height: cell.frame.height * CGFloat(course.courseTime)))
                    timeTable.backgroundColor = UIColor.orange
                    timeTable.alpha = 0.6
                    timeTable.accessibilityIdentifier = "MyCourse"
                    
                    let eventLabel = UILabel(frame: CGRect(x: 0, y: 0, width: timeTable.frame.width, height: timeTable.frame.height / 3))
                    eventLabel.text = course.subject
                    eventLabel.font = UIFont(name: "SpoqaHanSans-Bold", size: 12)
                    eventLabel.textColor = UIColor.white
                    eventLabel.lineBreakMode = .byCharWrapping
                    eventLabel.numberOfLines = 0
                    eventLabel.sizeToFit()
                    
                    timeTable.addSubview(eventLabel)
                    timeTable.addGestureRecognizer(gesture)
                
                    collectionView.addSubview(timeTable)
                    cell.layer.borderColor = UIColor.white.cgColor
                    cell.layer.borderWidth = 0.0
                }
            }
        }
    }
    collectionView.reloadInputViews()
}


/// 시작, 종료 시간을 비교하기 위한 tag값을 생성합니다. ex) 오후 3시 25분 -> 1200 + 300 + 25
func timeLabelTagValue(sunPosition: String, hour: String, minute: String) -> Int {
    func sunPositionValue(sunPosition: String) -> Int {
        switch sunPosition {
        case "오전":
            return 0
        case "오후":
            return 1200
        default:
            return 0
        }
    }
    return sunPositionValue(sunPosition: sunPosition) + Int(hour)! * 100 + Int(minute)!
    
}

extension String {
    /// param: 월요일~금요일, return: 1~5
    var stringToDayValue: String {
        get {
            switch self {
            case "월요일":
                return "1"
            case "화요일":
                return "2"
            case "수요일":
                return "3"
            case "목요일":
                return "4"
            case "금요일":
                return "5"
            default:
                return "0"
            }
        }
    }
}
