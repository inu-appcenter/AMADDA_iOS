//
//  GroupInfoVC.swift
//  Amadda
//
//  Created by mong on 2020/09/03.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class GroupInfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var group: Group?
    var groupColorDic = Dictionary<String, Any>()
    var selectedColor: UIColor?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var groupNameTextField: UITextField!
    @IBOutlet var colorLabelLeftConstraintFromColorView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        groupNameTextField.text = group?.group_name
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "공유 그룹 관리"
    }

    @IBAction func backBtn(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func confirmBtn(_ sender: Any) {
        if selectedColor != nil {
            print("##SelectedColor: \(selectedColor)")
            if userDefaults.dictionary(forKey: "groupColor") != nil {
                groupColorDic = userDefaults.dictionary(forKey: "groupColor")!
            }
            groupColorDic.updateValue((selectedColor!.toHexString()), forKey: "\(group!.share!)")
            print("##groupColorDic: \(groupColorDic)")
            userDefaults.set(groupColorDic, forKey: "groupColor")
            print(userDefaults.dictionary(forKey: "groupColor"))
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InviteCell") as? GroupInfoCell else {return UITableViewCell()}
        
        let seperator = UIView(frame: CGRect(x: cell.frame.origin.x + 10, y: cell.frame.height - 1, width: cell.frame.width - 20, height: 1))
        seperator.backgroundColor = UIColor(displayP3Red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        
        switch indexPath.row {
        case 0:
            cell.iconimageView.image = UIImage(named: "icon_group")
            cell.textField.placeholder = "초대하기"
            cell.textField.isUserInteractionEnabled = false
            cell.accessoryType = .disclosureIndicator
            cell.addSubview(seperator)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell") as? GroupColorPickerCell else {return UITableViewCell()}
            cell.iconImageView.image = UIImage(named: "icon_color")
            
            if userDefaults.dictionary(forKey: "groupColor")?["\(group!.share!)"] != nil {
                let color = userDefaults.dictionary(forKey: "groupColor")!["\(group!.share!)"] as! String
                cell.colorLabel.text = "   \(color)"
                cell.colorView.backgroundColor = UIColor(hex: color)
            }else if selectedColor != nil {
                cell.colorLabel.text = "   \(selectedColor!.toHexString())"
                cell.colorView.backgroundColor = selectedColor
            }else{
                print("##Saved Color None")
            }
            
            cell.accessoryType = .disclosureIndicator
            cell.addSubview(seperator)
            return cell
        case 2:
            cell.iconimageView.image = UIImage(named: "icon_Memo")
            cell.textField.placeholder = "메모"
            cell.textField.text = group?.memo
            cell.accessoryType = .none
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 0 = invite, 1 = color, 2 = memo
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "memberSegue", sender: nil)
        case 1:
            performSegue(withIdentifier: "colorSegue", sender: nil)
        default:
            print("else")
        }
    }

    
}
