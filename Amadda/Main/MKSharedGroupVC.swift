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

protocol selectColorDelegate {
    func open()
    func add()
}

class MKSharedGroupVC: UIViewController, selectColorDelegate {

    @IBOutlet var mkTableView: UITableView!

    
    var tableViewData = [cellData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mkTableView.delegate = self
        mkTableView.dataSource = self
        
        tableViewData = [cellData(opened: false, title: "title1", sectionData: ["cell1"]),
        cellData(opened: false, title: "title2", sectionData: ["cell1", "cell2", "cell3"]),
        cellData(opened: false, title: "title3", sectionData: ["cell1", "cell2", "cell3"])]

        // Do any additional setup after loading the view.
    }
    
    func open() {
        tableViewData[0].sectionData.append("cell2")
        if tableViewData[0].opened == true {
        tableViewData[0].opened = false
        let sections = IndexSet.init(integer: 0)

        UIView.performWithoutAnimation {
            mkTableView.reloadSections(sections, with: .none)
        }
        } else {
        tableViewData[0].opened = true
        let sections = IndexSet.init(integer: 0)

        UIView.performWithoutAnimation {
            mkTableView.reloadSections(sections, with: .none)
        }
        }
    }
    
    func add() {
        tableViewData[0].sectionData.append("cell2")
        let sections = IndexSet.init(integer: 0)

        UIView.performWithoutAnimation {
            mkTableView.reloadSections(sections, with: .none)
        }
    }
    
    
}

extension MKSharedGroupVC: UITableViewDelegate, UITableViewDataSource {
    
       func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 3
        }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if tableViewData[section].opened == true {
//                return tableViewData[section].sectionData.count
                return tableViewData[section].sectionData.count
            }else{
                return 1
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            print(indexPath.section)
            
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "inviteCell", for: indexPath) as! InviteCell
                    cell.delegate = self
                    return cell
                }else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "addEmailCell", for: indexPath) as! AddEmailCell
                    cell.delegate = self
                    return cell
                }
            }
            
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "inviteCell", for: indexPath)
                return cell
            } else if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "selectedColorCell", for: indexPath)
                return cell
            } else if indexPath.row == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "testCell12", for: indexPath)
                return cell
            }
        }
    
}
