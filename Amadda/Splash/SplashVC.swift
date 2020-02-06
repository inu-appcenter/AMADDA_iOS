//
//  SplashVC.swift
//  Amadda
//
//  Created by mong on 2020/02/06.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class SplashVC: UIViewController {
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+delayInSeconds){
            guard let LoginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else{return}
            self.present(LoginVC, animated: true, completion: nil)
        }
    }
}
