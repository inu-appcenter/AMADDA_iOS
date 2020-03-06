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
    
    override func viewDidLoad() {
        // Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = setLayout(collectionView: collectionView, height: timeLineStackView.frame.height)
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
