//
//  MainCalendarVC.swift
//  Amadda
//
//  Created by mong on 2020/02/10.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit
import Floaty
import FSCalendar

class MainCalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet var navigationItemBar: UINavigationItem!
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var dateTitleLabel: UILabel!
    
    @IBAction func changeCalendar(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let date = calendar.currentPage
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateTitleLabel.text = dateFormatter.string(from: date)
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = Locale.init(identifier: "ko_KR")

        /// 테스트 데이터 나중에 삭제 필
        let eventData = Schedule(id: "0", number: 0, schedule_name: "dummy", start: "2020-03-26", end: "2020-03-26", location: "home", alarm: nil, share: nil, key: nil, memo: "birthday")
        scheduleList.append(eventData)
        ///
        for schedule in scheduleList{
            if(dateFormatter.string(from: date) == schedule.start){
                return 1
            }
        }
        return 0
    }
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        return calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
    }
    
    override func viewDidLoad() {
        
        // MARK: Default Setting
        self.tabBarController?.tabBar.isHidden = true
        var dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "MMM d일 eeee"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        navigationItemBar.title = dateFormatter.string(from: Date())
        
        let titledate = calendar.currentPage
        let titleDateFormatter = DateFormatter()
        titleDateFormatter.dateFormat = "YYYY년 MM월"
        titleDateFormatter.locale = Locale(identifier: "ko-KR")
        dateTitleLabel.text = titleDateFormatter.string(from: date)
        
        // MARK: FSCalendar
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.calendarHeaderView.isHidden = true
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor.red
        
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

// MARK: FSCalender Custom Cell
class CustomCalendarCell: FSCalendarCell {
    
    private lazy var newDotView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        eventIndicator.subviews.first?.alpha = 0.0 // hide dots of library
        
        let newDotRect = CGRect(x: 0,
                                y: -self.frame.height + 5,
                                width: self.frame.width,
                                height: 5)

        newDotView.frame = newDotRect
        newDotView.backgroundColor = .red // {You want}
        eventIndicator.addSubview(newDotView)
    }
}
