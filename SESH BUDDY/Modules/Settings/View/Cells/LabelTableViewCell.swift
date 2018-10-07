//
//  LabelTableViewCell.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 07/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        setUPUI()
    }

    func setUPUI() {
        descLabel.font = Fonts.mavenProRegular.getFont(15)
        toggleSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        let onColor  = UIColor.orange
        let offColor = UIColor.textfieldBorderColor
        toggleSwitch.onTintColor = onColor
        /*For off state*/
        toggleSwitch.tintColor = offColor
        toggleSwitch.layer.cornerRadius = 16
        toggleSwitch.backgroundColor = offColor
    }
    func hideToogleButton(value: Bool){
        self.toggleSwitch.isHidden = value
    }
    
}
