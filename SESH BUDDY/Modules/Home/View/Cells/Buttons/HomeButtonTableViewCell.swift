//
//  HomeButtonTableViewCell.swift
//  SESH BUDDY
//
//  Created by test on 29/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class HomeButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.bgView.backgroundColor = .clear
    }
    func setUPUI(isButtonSelected: Bool, type: HomeViewSections){
        button.setTitle("", for: .normal)
        switch type {
        case .shmokButton:
            subTitleLabel.isHidden = true
            button.setTitle(AppStrings.SHMOKE.localized, for: .normal)
        case .matchButton:
            subTitleLabel.isHidden = true
            button.setTitle(AppStrings.MATCH.localized, for: .normal)
        case .dropButton:
            subTitleLabel.isHidden = true
            button.setTitle(AppStrings.DROP.localized, for: .normal)
        case .smoButton:
            subTitleLabel.isHidden = false
            button.setTitle(AppStrings.SMO.localized, for: .normal)
        case .buddyUpButton:
            
            subTitleLabel.isHidden = true
            button.setTitle(AppStrings.BUDDYUP.localized, for: .normal)
        default:
            break
        }
        
        let font = Fonts.mavenProMedium.getFont(17)
        button.titleLabel?.font =  font
        button.setTitleColor(UIColor.white, for: .normal)
        
        subTitleLabel.textColor = UIColor.white
        subTitleLabel.font = Fonts.mavenProRegular.getFont(9)
        if !isButtonSelected {
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
            button.backgroundColor = .clear
        } else {
            button.layer.borderColor = UIColor.clear.cgColor
            button.layer.borderWidth = 0
            button.backgroundColor = UIColor.themeNavBarColor
        }
        
    
    }
    
}
