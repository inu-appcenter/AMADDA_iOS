//
//  MenuViewController.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/23.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var delegate: HomeViewControllerDelegate?

    @IBOutlet var tableView: UITableView!
    @IBAction func settingPressed(_ sender: Any) {
        let naviController = self.storyboard?.instantiateViewController(withIdentifier: "navi")
        as! UINavigationController
        self.present(naviController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}
    

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupCell
        
        return cell
    }
    
        
}
