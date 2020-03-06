//
//  MajorTableVC.swift
//  Amadda
//
//  Created by mong on 2020/03/03.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class MajorTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ComputerScience().courseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MajorTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MajorTableViewCell") as? MajorTableViewCell else {return UITableViewCell()}
        cell.subjectLabel.text = ComputerScience().courseList[indexPath.row].subject
        cell.professorLabel.text = ComputerScience().courseList[indexPath.row].professor
        cell.dayLabel.text = ComputerScience().courseList[indexPath.row].dayString()
        cell.timePlaceLabel.text = ComputerScience().courseList[indexPath.row].timeAndPlace
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        해당 시간표 끝나는 시간에 맞춰서 Scroll 해줘야 하는데 rect 가 ScrollView Height보다 큰 y값 넣었을 시 작동을 안 함.
        나중에 시간표 불러와지면 그때 조금 더 자세하게 테스트 해보자
        */
        guard let AddCourseVC = self.navigationController?.parent as? AddCourseVC else {return}
        let startTime = Int(ComputerScience().courseList[indexPath.row].startTime)!
        let endTime = Int(ComputerScience().courseList[indexPath.row].endTime)!
        for time in stride(from: startTime, to: endTime, by: 1) {
            let timeIndexPath = IndexPath(row: time, section: 0)
            AddCourseVC.collectionView.cellForItem(at: timeIndexPath)!.backgroundColor = UIColor.red
        }
        AddCourseVC.collectionView.scrollToItem(at: IndexPath(row: startTime, section: 0), at: .centeredHorizontally, animated: true)
        AddCourseVC.collectionView.setNeedsLayout()
        let cellFrame = AddCourseVC.collectionView.cellForItem(at: IndexPath(row: startTime, section: 0))!.frame
        let rect: CGRect = CGRect(x: cellFrame.origin.x, y: cellFrame.origin.y + cellFrame.height, width: cellFrame.width, height: cellFrame.height)
        AddCourseVC.scrollView.scrollRectToVisible(rect, animated: true)
    }
}
