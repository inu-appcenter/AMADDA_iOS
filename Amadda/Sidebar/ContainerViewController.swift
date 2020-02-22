//
//  ContainerViewController.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/23.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var menuController: MenuViewController!
    var centerController: UIViewController!
    var isExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    
    func configureHomeController() {
        let homeController = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController

        homeController.delegate = self
        centerController = UINavigationController(rootViewController: homeController)

        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }

    func configureMenuController() {
        if menuController == nil {
            menuController = self.storyboard?.instantiateViewController(withIdentifier: "menuVC") as? MenuViewController
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func animate(shouldExpand: Bool) {
        
        if shouldExpand {
            // show menu
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 90
            }, completion: nil)

        } else {
            // hide menu
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                           self.centerController.view.frame.origin.x = 0
                       }, completion: nil)
        }
        animateStatusBar()
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func handleMenuToggle() {
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        animate(shouldExpand: isExpanded)
    }
}
