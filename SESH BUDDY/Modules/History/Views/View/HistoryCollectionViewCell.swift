//
//  HistoryCollectionViewCell.swift
//  SESH BUDDY
//
//  Created by test on 07/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var seshTypeLabel: UILabel!
    @IBOutlet weak var viewSeshTypeButton: UIButton!
    @IBOutlet weak var seshTitleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUPUI()
    }
    func setUPUI() {
        bgView.backgroundColor = UIColor.themeNavBarColor
        seshTypeLabel.textColor = .white
        seshTitleLabel.textColor = .white
        viewSeshTypeButton.setTitleColor(UIColor.themeNavBarColor, for: .normal)
        viewSeshTypeButton.backgroundColor = UIColor.themeYellowColor
        
        let seshTypeFont = Fonts.mavenProBold.getFont(15)
        let seshTitleLabelFont = Fonts.mavenProRegular.getFont(13)
        let seshButtonFont = Fonts.mavenProRegular.getFont(17)
        
        seshTypeLabel.font = seshTypeFont
        seshTitleLabel.font = seshTitleLabelFont
        viewSeshTypeButton.titleLabel?.font = seshButtonFont
    }
}
