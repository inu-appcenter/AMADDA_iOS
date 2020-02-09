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
    
    @IBAction func LoginBtn(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC else {return}
        let mainTabBarController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController")
        present(mainTabBarController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        
    }
}
