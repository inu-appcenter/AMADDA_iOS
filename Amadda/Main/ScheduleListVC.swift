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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scheduleList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
//        let cellId = data == nil ? "Cell" : "CellWith"
        let cellId: String
        
        switch indexPath.row {
        case 0: cellId = "cellWithDate"
        case 1: cellId = "cellWithDateEtc"
        case 2: cellId = "cellWithAllComp"
        default: cellId = "cellWithAllComp"
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScheduleCell

        cell.dateLabel.text = "\(scheduleList[indexPath.row].start!) ~ \(scheduleList[indexPath.row].end!)"
//        cell.memoLabel.text = scheduleList[indexPath.row].memo
//        cell.locationLabel.text = scheduleList[indexPath.row].location
        cell.scheduleTitle.text = scheduleList[indexPath.row].schedule_name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        return CGSize(width: self.view.frame.width, height: 175)
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

}

