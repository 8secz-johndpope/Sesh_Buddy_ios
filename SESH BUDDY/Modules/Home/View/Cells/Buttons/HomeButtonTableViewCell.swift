//
//  HomeButtonTableViewCell.swift
//  SESH BUDDY
//
//  Created by test on 29/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class HomeButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.bgView.backgroundColor = .clear
    }
    func setUPUI(isButtonSelected: Bool, type: SessionType){
        switch type {
        case .SHMOKE:
            button.setTitle(AppStrings.SHMOKE.localized, for: .normal)
        case .MATCH:
            button.setTitle(AppStrings.MATCH.localized, for: .normal)
        case .DROP:
            button.setTitle(AppStrings.DROP.localized, for: .normal)
        case .SMO:
            button.setTitle(AppStrings.SMO.localized, for: .normal)
        default:
            break
        }
        
        let font = Fonts.mavenProMedium.getFont(17)
        button.titleLabel?.font =  font
        button.setTitleColor(UIColor.white, for: .normal)
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
