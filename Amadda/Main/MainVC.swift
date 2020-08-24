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

var scheduleList: [Schedule] = [Schedule]()
var testData = [    ["1-1","1-2","1-3","1-4","1-5","1-6","1-7","1-8","1-9","1-10","1-11","1-12","1-13","1-14",],["2-1","2-2","2-3","2-4","2-5","2-6","2-7","2-8","2-9","2-10","2-11","2-12","2-13","2-14",],["3-1","3-2","3-3","3-4","3-5","3-6","3-7","3-8","3-9","3-10","3-11","3-12","3-13","3-14",],["4-1","4-2","4-3","4-4","4-5","4-6","4-7","4-8","4-9","4-10","4-11","4-12","4-13","4-14",],["5-1","5-2","5-3","5-4","5-5","5-6","5-7","5-8","5-9","5-10","5-11","5-12","5-13","5-14",]
]

class MainVC: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var delegate: HomeViewControllerDelegate?
//    let courseData = ComputerScience()
    
    @IBOutlet var navigationItemBar: UINavigationItem!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var timeLineStackView: UIStackView!
    @IBOutlet var dayStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        showAlertController(title: "", message: "시간표 삭제?", completionHandler: {(_) in
            UserDefaults.standard.removeObject(forKey: "MyCourse")
        })
        // MARK: Default Setting
        self.tabBarController?.tabBar.isHidden = true
        var dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "MMM d일 eeee"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        navigationItemBar.title = dateFormatter.string(from: Date())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_sideBar"), style: .plain , target: self, action: #selector(handleMenuToggle))
        navigationController?.navigationBar.barTintColor = UIColor(red: 0x3C, green: 0xB8, blue: 0xFE)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        // MARK: StackView Border Layer
        for subview in dayStackView.arrangedSubviews {
            subview.layer.borderColor = UIColor.lightGray.cgColor
            subview.layer.borderWidth = 0.3
        }
        for subview in timeLineStackView.arrangedSubviews {
            subview.layer.borderColor = UIColor.lightGray.cgColor
            subview.layer.borderWidth = 0.3
        }
        
        // MARK: CollectionView (TimeTable)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.collectionViewLayout = setLayout(collectionView: collectionView, height: timeLineStackView.frame.height)
        
        // MARK: Floaty
        let floaty = Floaty()
                
        floaty.addItem("공유 일정", icon: UIImage(), handler: {item in
            print("공유일정")
            guard let AddShareEventNavigation = self.storyboard?.instantiateViewController(withIdentifier: "AddShareEventNavigation") else {return}
            self.present(AddShareEventNavigation, animated: true, completion: nil)
        })
        floaty.addItem("개인 일정", icon: UIImage(), handler: {item in
            print("개인일정")
            guard let AddPersonalEventNavigation = self.storyboard?.instantiateViewController(withIdentifier: "AddPersonalEventNavigation") else {return}
            self.present(AddPersonalEventNavigation, animated: true, completion: nil)
        })
        floaty.addItem("수업 추가", icon: UIImage(), handler: {item in
            guard let AddCourseVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCourseNavigationController") else {return}
            self.present(AddCourseVC, animated: true, completion: nil)
        })

        floaty.itemSpace = 10
        
        floaty.items[0].iconImageView.frame = CGRect(x: -95, y: -150, width: 150, height: 250)
        floaty.items[0].iconImageView.contentMode = .scaleAspectFit
        floaty.items[0].iconImageView.image = UIImage(named: "bg_Floaty")
        floaty.items[0].iconImageView.tintColor = UIColor.clear
        floaty.items[0].buttonColor = UIColor.clear
        floaty.items[0].titleColor = UIColor.clear
//        floaty.items[0].backgroundColor = UIColor.blue
                
        floaty.items[1].itemBackgroundColor = UIColor.clear
        floaty.items[1].buttonColor = UIColor.clear
        floaty.items[1].titleColor = UIColor.clear
        
        floaty.items[2].itemBackgroundColor = UIColor.clear
        floaty.items[2].buttonColor = UIColor.clear
        floaty.items[2].titleColor = UIColor.clear
                
        floaty.paddingX = 20
        floaty.paddingY = 34
        
        self.view.addSubview(floaty)
    }
    override func viewWillAppear(_ animated: Bool) {
        // MARK: 개인 일정 UI
        /**
        일단 저장 후 불러오는게 성공 했으나 gesture Recognizer & subject.label 이 증발 해버리는 현상 발생.
         addCourseManual에서 저장 할때마다 UserDefault로 올리는게 아니라 [Course] 전역 변수로 만들고
         앱 첫 실행 시 받아오고, 앱 꺼졌을때 저장만 해서 하면 해결 가능해 보임.
         -> UIGestureRecognizer는 한 view에만 할당 가능. 그냥 UIButton으로 바꿔버리고 action을 push로 하는걸로 해결.
         */
        let gesture = UITapGestureRecognizer(target: self, action: #selector(timeTableDidSelect))
        for view in collectionView.subviews {
            if view.accessibilityIdentifier == "MyCourse" {
                let btn = view as! UIButton
                btn.addTarget(self, action: #selector(timeTableDidSelect), for: .touchUpInside)
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        drawManualEvent(collectionView: self.collectionView)
    }
    override func viewDidDisappear(_ animated: Bool) {
        for view in collectionView.subviews {
            if view.accessibilityIdentifier == "MyCourse" {
                view.removeFromSuperview()
            }
        }
    }

    
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
        /// 시간표 grid Label (testData)
        /*
        label.text = "\(testData[indexPath.section][indexPath.row])"
        label.textColor = UIColor.black
        cell.addSubview(label)
        */
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.3
        
        /*
        // MARK: 시간표 등록 완료된 item 표시
        for course in courseData.courseList {
            let courseIndexPath = IndexPath(row: Int(course.startTime)!-1, section: Int(course.day)!-1)
            let courseRange: CGFloat = CGFloat(Int(course.endTime)! - Int(course.startTime)!)
            if courseIndexPath == indexPath {
                let timeTable = UIView(frame: CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.width, height: cell.frame.height * courseRange))
                timeTable.backgroundColor = UIColor.lightGray
                
                let courseLabel = UILabel(frame: CGRect(x: 0, y: 0, width: timeTable.frame.width, height: timeTable.frame.height / 3))
//                courseLabel.backgroundColor = UIColor.blue
                courseLabel.text = course.subject
                courseLabel.font = UIFont(name: "SpoqaHanSans-Bold", size: 12)
                courseLabel.textColor = UIColor.white
                courseLabel.lineBreakMode = .byCharWrapping
                courseLabel.numberOfLines = 0
                courseLabel.sizeToFit()
                timeTable.addSubview(courseLabel)
                
                let placeLabel = UILabel(frame: CGRect(x: courseLabel.frame.minX, y: courseLabel.frame.maxY + 5, width: timeTable.frame.width, height: timeTable.frame.height / 3))
//                placeLabel.backgroundColor = UIColor.green
                placeLabel.text = course.place
                placeLabel.font = UIFont(name: "SpoqaHanSans-Regular", size: 10)
                placeLabel.textColor = UIColor.white
                placeLabel.lineBreakMode = .byCharWrapping
                placeLabel.numberOfLines = 0
                placeLabel.sizeToFit()
                timeTable.addSubview(placeLabel)
                
                let gesture = UITapGestureRecognizer(target: self, action: #selector(timeTableDidSelect))
                timeTable.addGestureRecognizer(gesture)
                
                collectionView.addSubview(timeTable)
                cell.layer.borderColor = UIColor.lightGray.cgColor
                cell.layer.borderWidth = 0.0
            }
        }
 */
        /*
        /// 겹치는 시간표 test
        if indexPath == [0,5] || indexPath == [4,3] {
            let timeTable = UIView(frame: CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.width, height: cell.frame.height * 3))
            timeTable.backgroundColor = UIColor.orange
            timeTable.alpha = 0.6
            
            let eventLabel = UILabel(frame: CGRect(x: 0, y: 0, width: timeTable.frame.width, height: timeTable.frame.height / 3))
            eventLabel.text = "캘린더 팀 회의"
            eventLabel.font = UIFont(name: "SpoqaHanSans-Bold", size: 12)
            eventLabel.textColor = UIColor.white
            eventLabel.lineBreakMode = .byCharWrapping
            eventLabel.numberOfLines = 0
            eventLabel.sizeToFit()
            timeTable.addSubview(eventLabel)
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(timeTableDidSelect))
            timeTable.addGestureRecognizer(gesture)
            
            collectionView.addSubview(timeTable)
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 0.0
        }
 */
        // MARK: 오늘을 나타내는 BG Color Set
        if getDayOfWeek() == indexPath.section {
            cell.backgroundColor = UIColor.todayBackGround
            dayStackView.arrangedSubviews[getDayOfWeek()].backgroundColor = UIColor.todayBackGround
        }
        return cell
    }

    @objc func timeTableDidSelect(){
        guard let ScheduleListVC = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleListVC") as? ScheduleListVC else{return}
        ScheduleListVC.scheduleList = scheduleList
        self.navigationController?.pushViewController(ScheduleListVC, animated: true)
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
        return CGSize(width: collectionView.frame.width / 5.0, height: timeLineStackView.frame.height / CGFloat(14))
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle()
    }
    
    /// 직접 추가한 일정을 불러와서 collectionView에 UI를 그립니다
    /*
     viewwillapper, viewdidappear 에 버튼 하나를 추가하면 바로 추가 댐.
     semaphore 적용해도 안댐
     if let cell = collectionView.cellForItem 에서 cell을 못 불러오는듯.
     collectionView가 다 생성 되기 전에 할당하려고 해서 그런가?
     */
    private func drawManualEvent(collectionView: UICollectionView) {
        if let data = UserDefaults.standard.value(forKey: "MyCourse") as? Data {
            if let myCourse = try? PropertyListDecoder().decode(Array<Course>.self, from: data){
                print(myCourse)
                for course in myCourse{
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
                        
                        timeTable.addTarget(self, action: #selector(timeTableDidSelect), for: .touchUpInside)
                        
                        timeTable.addSubview(placeLabel)
                        timeTable.addSubview(eventLabel)
                        
                        collectionView.addSubview(timeTable)
                        cell.layer.borderColor = UIColor.white.cgColor
                        cell.layer.borderWidth = 0.0
                    }
                }
            }
        }
        collectionView.reloadInputViews()
    }
}

func networkTest() {
    let networkManager = NetworkManager()
    
    networkManager.login(id: "201400900", password: "010010") { (result) in
        print("로그인 \(result)")
    }
    
    networkManager.seeProfile { (result) in
        print("프로필 보기 \(result)")
    }
    
    networkManager.modifypassword(password: "010010", newPassword: "01050427741") { (result) in
        print("비밀번호 수정\(result)")
    }
    
    networkManager.getTempPassword(id: "201400900", name: "이승환") { (result) in
        print("임시비밀번호 \(result)")
    }
    
    let img = UIImage(named: "시그모이드 함수")
    networkManager.uploadProfileImg(image: img!)
    
    networkManager.uploadProfileImg(image: img!)
    
    networkManager.deleteProfileImg()
    
    networkManager.setInviteOption(flag: 1)
    
    networkManager.addSchedule(name: "테스트3", start: "2020-03-24 10:11:11", end: "2020-03-25 10:11:11", location: nil, alarm: nil, share: nil, memo: "share가 뭐지") { (result) in
        print("스케줄 추가 \(result)")
    }
    
    networkManager.seeScheduleDetail(number: 34) { (result) in
        print("스케줄 상세 \(result)")
    }
    
    networkManager.seeAllSchedules { (result) in
        print("모든 스케줄 \(result)")
    }
    
    networkManager.deleteSchedule(number: 34)

}

/// CollectionView 시간표 Layout
func setLayout(collectionView: UICollectionView, height: CGFloat) -> UICollectionViewLayout {
    let layout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
//    layout.itemSize = CGSize(width: collectionView.frame.width / 5.0, height: height / 14.0)
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    return layout
}

/// return 0 ~ 4 as 월 ~ 금 ( 토 ~ 일, return -1)
func getDayOfWeek() -> Int {
    let calendar = Calendar.current
    let todayValue = calendar.component(.weekday, from: Date())
    switch todayValue {
    case 1, 7:
        return -1
    case 2:
        return 0
    case 3:
        return 1
    case 4:
        return 2
    case 5:
        return 3
    case 6:
        return 4
    default:
        return -1
    }
}


