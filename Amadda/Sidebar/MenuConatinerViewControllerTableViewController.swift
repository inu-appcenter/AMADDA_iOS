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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.cellForRow(at: indexPath)?.reuseIdentifier {
        case "invitationCell":
            guard let invitaionNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "invitationNavigationController") as? UINavigationController else {return}
            self.present(invitaionNavigationController, animated: true, completion: nil)
        default:
            return
        }
    }


}
