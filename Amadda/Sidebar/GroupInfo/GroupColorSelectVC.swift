//
//  GroupColorSelectVC.swift
//  Amadda
//
//  Created by mong on 2020/09/03.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit
import ChromaColorPicker

class GroupColorSelectVC: UIViewController, ChromaColorPickerDelegate {
    
    @IBOutlet var colorPickerView: ChromaColorPicker!
    @IBOutlet var colorSliderView: ChromaBrightnessSlider!
    @IBOutlet var selectedColorView: UIView!
    
    
    @IBAction func confirmBtn(_ sender: Any) {
        let nav = self.presentingViewController as? UINavigationController
        guard let GroupInfoVC = nav?.viewControllers.last as? GroupInfoVC else {return}
        GroupInfoVC.selectedColor = selectedColorView.backgroundColor
        GroupInfoVC.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        initColorPickerView(colorPicker: colorPickerView, colorSlider: colorSliderView)
    }
    
    func colorPickerHandleDidChange(_ colorPicker: ChromaColorPicker, handle: ChromaColorHandle, to color: UIColor) {
        selectedColorView.backgroundColor = color
        
    }
    
    private func initColorPickerView(colorPicker: ChromaColorPicker, colorSlider: ChromaBrightnessSlider) {
        colorPicker.connect(colorSlider)
        
        let peachColor = UIColor(red: 1, green: 203 / 255, blue: 164 / 255, alpha: 1)
        colorPicker.addHandle(at: peachColor)
        colorPicker.delegate = self
    }
}
