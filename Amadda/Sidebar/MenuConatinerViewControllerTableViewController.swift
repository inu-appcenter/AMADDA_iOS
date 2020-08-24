//
//  MenuConatinerViewControllerTableViewController.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/23.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

class MenuConatinerViewControllerTableViewController: UITableViewController {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var majorLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager().seeProfile(completion: {(response) in
            do {
                let imageData = try Data(contentsOf: URL(fileURLWithPath: response?.user?.user_image ?? ""))
                self.profileImage.image = UIImage(data: imageData)
            }catch {
                print("## Get Profile Image Data Failure")
            }
            self.majorLabel.text = response?.user?.major
            self.nameLabel.text = response?.user?.name
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {

        }
    }


}
