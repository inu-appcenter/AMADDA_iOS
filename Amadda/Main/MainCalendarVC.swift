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

class MainCalendarVC: UIViewController {
    @IBOutlet var navigationItemBar: UINavigationItem!
    
    @IBAction func changeCalendar(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        
        // MARK: Default Setting
        self.tabBarController?.tabBar.isHidden = true
        var dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "MMM d일 eeee"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        navigationItemBar.title = dateFormatter.string(from: Date())
        
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
