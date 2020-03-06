//
//  CustomDateFormatter.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/03/04.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

class CustomDateFormatter: DateFormatter {
    
    override init() {
        super.init()
        
        self.dateFormat = "yyyy. M. d (E)  a  hh:mm"
        self.locale = Locale(identifier: "ko_KR")
    }
    
    init(dateStyle: DateFormatter.Style ,timeStyle: DateFormatter.Style) {
        super.init()
        
        self.dateFormat = "yyyy. M. d (E)  a  hh:mm"
        self.locale = Locale(identifier: "ko_KR")
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
