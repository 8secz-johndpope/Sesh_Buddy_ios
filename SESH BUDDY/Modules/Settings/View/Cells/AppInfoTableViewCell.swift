//
//  AppInfoTableViewCell.swift
//  SESH BUDDY
//
//  Created by test on 14/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class AppInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var appInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUPUI()
    }
    
    func setUPUI() {
        let firstString = NSMutableAttributedString(string: "Version ").color(UIColor.themeDarkTextColor).font(Fonts.mavenProRegular.getFont(11))
        let secondString = NSMutableAttributedString(string: "1.0.0").color(UIColor.themeDarkTextColor).font(Fonts.mavenProMedium.getFont(11))
        appInfoLabel.attributedText = firstString + secondString
        
        let appInfoText = "Copyright 2018 Sesh Buddies.\n All logos are registered trademark of Sesh Buddies, LLC. All right reserved."
        versionLabel.text = appInfoText
        versionLabel.font = Fonts.mavenProRegular.getFont(10)
        versionLabel.textColor = UIColor.themeDarkTextColor
        
        
    }

    
}
