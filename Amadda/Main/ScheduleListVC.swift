//
//  ScheduleListVC.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/28.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

class ScheduleListVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var scheduleList = [Schedule]()
    var groupKey: Int?
    
    @IBAction func backBtn(_ sender: Any) {
        if self.navigationController?.restorationIdentifier == "ScheduleListNav" {
            self.dismiss(animated: true, completion: nil)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        if self.navigationController?.restorationIdentifier == "ScheduleListNav" {
            self.title = "개인일정"
        }else {
            self.title = "전체일정"
        }
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        if groupKey == -1 {
            NetworkManager().seePersonalSchedules(completion: {(response) in
                if response?.schedules != nil {
                    self.scheduleList = (response?.schedules)!
                }else {
                    print("schedules are empty")
                }
                   self.collectionView.reloadData()
            })
        }else {
        NetworkManager().seeAllSchedules(completion: {(response) in
            if response?.schedules != nil {
                self.scheduleList = (response?.schedules)!
            }else {
                print("schedules are empty")
            }
               self.collectionView.reloadData()
        })
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(scheduleList.count)
        return scheduleList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
//        let cellId = data == nil ? "Cell" : "CellWith"
        let cellId: String
        
        switch indexPath.row {
//        case 0: cellId = "cellWithDate"
//        case 1: cellId = "cellWithDateEtc"
//        case 2: cellId = "cellWithAllComp"
        default: cellId = "cellWithAllComp"
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScheduleCell
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentSchedule = scheduleList[indexPath.row]
        guard let ScheduleDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleDetailVC") as? ScheduleDetailVC else {return}
        
        ScheduleDetailVC.scheduleNumber = currentSchedule.number
        ScheduleDetailVC.schedule = currentSchedule
        self.navigationController?.pushViewController(ScheduleDetailVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            return footer
        } else {
            let Header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            return Header
        }
    }
    @IBAction func addPersonalEventBtn(_ sender: Any) {
        guard let AddPersonalEventNavigation = storyboard?.instantiateViewController(withIdentifier: "AddPersonalEventNavigation") as? UINavigationController else {return}
        self.present(AddPersonalEventNavigation, animated: true, completion: nil)
    }
}


