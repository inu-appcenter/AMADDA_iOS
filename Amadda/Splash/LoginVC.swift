//
//  LoginVC.swift
//  Amadda
//
//  Created by mong on 2020/02/06.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    
    @IBAction func LoginBtn(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC else {return}
        let mainTabBarController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController")
        
        NetworkManager().login(id: emailTextField.text ?? "", password: pwTextField.text ?? "", completion: {(response) in
            guard let response = response else {return}
            if response.success! {
                self.present(mainTabBarController, animated: true, completion: nil)
            }else {
                self.showDefaultAlertController(title: "로그인 실패", message: "아이디와 비밀번호를 확인 하세요", completionHandler: nil)
            }
        })
        
    }
    
    
    override func viewDidLoad() {
        
    }
}
