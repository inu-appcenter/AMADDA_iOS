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
    
    @IBAction func addNewGroupBtn(_ sender: Any) {
        guard let AddNewGroupNav = storyboard?.instantiateViewController(withIdentifier: "AddNewGroupNav") as? UINavigationController else {return}
        AddNewGroupNav.modalPresentationStyle = .fullScreen
        present(AddNewGroupNav, animated: true, completion: nil)
    }
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
        case "myScheduleCell":
            guard let ScheduleListVC = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleListVC") as? ScheduleListVC else {return}
            ScheduleListVC.groupKey = -1
            
            guard let ScheduleListNav = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleListNav") as? UINavigationController else {return}
            present(ScheduleListNav, animated: true, completion: nil)
            /*
            let nav = initScheduleListNav(viewControllers: [ScheduleListVC])
            
            present(initScheduleListNav(viewControllers: [ScheduleListVC]), animated: true, completion: nil)
 */
        default:
            return
        }
    }

    
    private func initScheduleListNav(viewControllers: [UIViewController]) -> UINavigationController {
        let nav = UINavigationController()
        nav.setViewControllers(viewControllers, animated: true)
        nav.modalPresentationStyle = .fullScreen
        return nav
    }
}
