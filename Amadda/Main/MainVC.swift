//
//  ViewController.swift
//  Amadda
//
//  Created by mong on 2020/02/06.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit
import Floaty

protocol HomeViewControllerDelegate {
    func handleMenuToggle()
}

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var delegate: HomeViewControllerDelegate?
    
    var testData = [    ["1-1","1-2","1-3","1-4","1-5","1-6","1-7","1-8","1-9","1-10","1-11","1-12","1-13","1-14",],["2-1","2-2","2-3","2-4","2-5","2-6","2-7","2-8","2-9","2-10","2-11","2-12","2-13","2-14",],["3-1","3-2","3-3","3-4","3-5","3-6","3-7","3-8","3-9","3-10","3-11","3-12","3-13","3-14",],["4-1","4-2","4-3","4-4","4-5","4-6","4-7","4-8","4-9","4-10","4-11","4-12","4-13","4-14",],["5-1","5-2","5-3","5-4","5-5","5-6","5-7","5-8","5-9","5-10","5-11","5-12","5-13","5-14",]
    ]
    
    @IBOutlet var navigationItemBar: UINavigationItem!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var timeLineStackView: UIStackView!
    
    @IBAction func changeCalendar(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return testData.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testData[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCell else {return UICollectionViewCell()}
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: 20))
        label.text = "\(testData[indexPath.section][indexPath.row])"
        label.textColor = UIColor.black
        cell.addSubview(label)
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.3
        
        if indexPath == [0,0] || indexPath == [0,5]{
            let timeTable = UIView(frame: CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.width, height: cell.frame.height * 3))
            timeTable.backgroundColor = UIColor.orange
            let gesture = UITapGestureRecognizer(target: self, action: #selector(timeTableDidSelect))
            timeTable.addGestureRecognizer(gesture)
            
            collectionView.addSubview(timeTable)
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.borderWidth = 0.0
            cell.tag = 1
        }
        return cell
    }

    @objc func timeTableDidSelect(){
        guard let TimeLineVC = self.storyboard?.instantiateViewController(withIdentifier: "TimeLineVC") as? TimeLineVC else{return}
        self.navigationController?.pushViewController(TimeLineVC, animated: true)
    }
    
    // MARK: 시간표 아이템 선택 Handler
    /*
     위에 collectionView.addSubview(timeTable) 로 해두면 timeTableView에다가 gesture를 달아서 Handler 만들어 줘야 하고,
     cell.addSubview(timeTable) 로 해두면 각각 cell마다 높이 계산해서 bgColor 지정 해줘야함. 이러면 더 귀찮아질듯 그래서 1안 선택.
    */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath)?.tag == 1 {
            print("item exist")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5.0, height: collectionView.frame.height / CGFloat(13))
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "사이드바", style: .plain, target: self, action: #selector(handleMenuToggle))
        navigationController?.navigationBar.barTintColor = UIColor(red: 0x3C, green: 0xB8, blue: 0xFE)
        
        // MARK: Default Setting
        self.tabBarController?.tabBar.isHidden = true
        var dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "MMM d일 eeee"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        navigationItemBar.title = dateFormatter.string(from: Date())
        
        // MARK: CollectionView (TimeTable)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = setLayout(collectionView: collectionView, height: timeLineStackView.frame.height)
        
        // MARK: Floaty
        let floaty = Floaty()
                
        floaty.addItem("공유 일정", icon: UIImage(), handler: {item in
            print("공유일정")
            guard let AddShareEventVC = self.storyboard?.instantiateViewController(withIdentifier: "AddShareEventVC") as? AddShareEventVC else {return}
            self.present(AddShareEventVC, animated: true, completion: nil)
        })
        floaty.addItem("개인 일정", icon: UIImage(), handler: {item in
            print("개인일정")
            guard let AddPersonalEventVC = self.storyboard?.instantiateViewController(withIdentifier: "AddPersonalEventVC") as? AddPersonalEventVC else {return}
            guard let AddPersonalEventNavigation = self.storyboard?.instantiateViewController(withIdentifier: "AddPersonalEventNavigation") else {return}
            self.present(AddPersonalEventNavigation, animated: true, completion: nil)
        })
        floaty.addItem("수업 추가", icon: UIImage(), handler: {item in
            guard let AddCourseVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCourseVC") as? AddCourseVC else {return}
            self.present(AddCourseVC, animated: true, completion: nil)
        })

        floaty.items[0].iconImageView.frame = CGRect(x: -100, y: -30, width: 150, height: 50)
        floaty.items[0].iconImageView.tintColor = UIColor.clear
        floaty.items[0].buttonColor = UIColor.clear
                
        floaty.items[1].itemBackgroundColor = UIColor.clear
        floaty.items[1].buttonColor = UIColor.clear
        floaty.items[1].titleColor = UIColor.white
                
        floaty.paddingX = 30
        floaty.paddingY = 40
        
        self.view.addSubview(floaty)
                
    }
}

func setLayout(collectionView: UICollectionView, height: CGFloat) -> UICollectionViewLayout {
    let layout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
//    layout.itemSize = CGSize(width: collectionView.frame.width / 5.0, height: height / 14.0)
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    return layout
}
