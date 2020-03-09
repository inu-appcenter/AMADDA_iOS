//
//  MKSharedGroupVC.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/03/08.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class MKSharedGroupVC: UIViewController {
    
    @IBOutlet var mkTableView: UITableView!
    var tableViewData = [cellData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mkTableView.delegate = self
        mkTableView.dataSource = self
        
        tableViewData = [cellData(opened: false, title: "title1", sectionData: ["cell1", "cell2", "cell3"]),
        cellData(opened: false, title: "title2", sectionData: ["cell1", "cell2", "cell3"]),
        cellData(opened: false, title: "title3", sectionData: ["cell1", "cell2", "cell3"])]

        // Do any additional setup after loading the view.
    }
}

extension MKSharedGroupVC: UITableViewDelegate, UITableViewDataSource {
    
       func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
    //        return 3
            return 1
        }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        if tableViewData[section].opened == true {
    //            return tableViewData[section].sectionData.count
    //        }else{
    //            return 1
    //        }
            return 3
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "inviteCell", for: indexPath)
                return cell
            } else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "selectedColorCell", for: indexPath)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
                return cell
            }
        }
    
}
