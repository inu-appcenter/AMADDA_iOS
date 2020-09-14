//
//  ScheduleCell.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/02/28.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
    
    var widthConst: NSLayoutConstraint?
    
    @IBOutlet var scheduleTitle: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var memoLabel: UILabel!
    @IBOutlet var colorBadgeView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        widthConst = contentView.widthAnchor.constraint(equalToConstant: 0)
    }
    
    override func updateConstraints() {
        widthConst?.constant = superview!.bounds.width * 0.94 
        widthConst?.isActive = true
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
        
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    override func prepareForReuse() {
        locationLabel.text = ""
        memoLabel.text = ""
        colorBadgeView.backgroundColor = UIColor.white
    }
}


