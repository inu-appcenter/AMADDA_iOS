//
//  SearchCourseTableVC.swift
//  Amadda
//
//  Created by mong on 2020/02/26.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class SearchCourseTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AddCourseTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddCourseTableViewCell") as? AddCourseTableViewCell else {return UITableViewCell()}
        
        cell.typeLabel.text = courseType[indexPath.row]
        return cell
    }
}
