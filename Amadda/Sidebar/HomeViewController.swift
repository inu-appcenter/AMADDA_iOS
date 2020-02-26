//
//  HomeViewController.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/23.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate {
    func handleMenuToggle()
}

class HomeViewController: UIViewController {
    
    var delegate: HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        self.view.backgroundColor = .brown
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "아마따"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "사이드바", style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle()
    }

}
