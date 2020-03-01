//
//  UIColor.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/23.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    @nonobjc class var mainBlue: UIColor {
        return UIColor(red: 30 / 255.0, green: 177 / 255.0, blue: 252 / 255.0, alpha: 1)
    }
    @nonobjc class var textFieldBackGround: UIColor {
        return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
    }
    @nonobjc class var textGray: UIColor {
        return UIColor(red: 106 / 255.0, green: 106 / 255.0, blue: 106 / 255.0, alpha: 1)
    }
}
