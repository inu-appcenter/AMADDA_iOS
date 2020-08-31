//
//  GroupScheduleListVC.swift
//  Amadda
//
//  Created by mong on 2020/08/31.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class GroupScheduleListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var scheduleList = [Schedule]()
    var groupName: String?
    var groupKey: Int?
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.topItem?.title = groupName
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager().seeGroupSchedule(share: groupKey!, completion: {(response) in
            if response?.schedules != nil {
                self.scheduleList = (response?.schedules)!
            }else {
                print("schedules are empty")
            }
            self.collectionView.reloadData()
            print("reload complete")
        })
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(scheduleList.count)
        return scheduleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
//        let cellId = data == nil ? "Cell" : "CellWith"
        let cellId: String
        
        switch indexPath.row {
//        case 0: cellId = "cellWithDate"
//        case 1: cellId = "cellWithDateEtc"
//        case 2: cellId = "cellWithAllComp"
        default: cellId = "cellWithAllComp"
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? GroupScheduleCell else {return UICollectionViewCell()}
        let currentSchedule = scheduleList[indexPath.row]
        cell.colorBadgeView.isHidden = true
        
        let dateValue = currentSchedule.getDate(time: .startDay)
        let timeValue = currentSchedule.getDate(time: .onlyTime)
        cell.dateLabel.text = "\(dateValue)\n\(timeValue)"
        cell.scheduleTitle.text = scheduleList[indexPath.row].schedule_name
        
        cell.dateLabel.font = UIFont(name: "SpoqaHanSans-Bold", size: 16)
        cell.scheduleTitle.font = UIFont(name: "SpoqaHanSans-Bold", size: 16)
        
        if currentSchedule.memo != nil {
            cell.memoLabel.text = currentSchedule.memo
            cell.memoLabel.font = UIFont(name: "SpoqaHanSans-Bold", size: 16)
        }
        if currentSchedule.location != nil {
            cell.locationLabel.text = currentSchedule.location
            cell.locationLabel.font = UIFont(name: "SpoqaHanSans-Bold", size: 16)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        return CGSize(width: self.view.frame.width, height: 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentSchedule = scheduleList[indexPath.row]
        guard let ScheduleDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleDetailVC") as? ScheduleDetailVC else {return}
        
        ScheduleDetailVC.scheduleNumber = currentSchedule.number
        ScheduleDetailVC.schedule = currentSchedule
        self.navigationController?.pushViewController(ScheduleDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            footer.isHidden = true
            return footer
        } else {
            let Header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            return Header
        }
    }

    

}
