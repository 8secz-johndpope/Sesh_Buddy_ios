//
//  TextViewTableViewCell.swift
//  SESH BUDDY
//
//  Created by Apple on 12/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var characterLimitLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var sepratorView: UIView!
    @IBOutlet weak var profileTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        sepratorView.backgroundColor = UIColor.backgroundGrey
        let smallFont = Fonts.mavenProRegular.getFont(11)
        let textfieldFont = Fonts.mavenProRegular.getFont(14)
        let characterLabelFont = Fonts.mavenProRegular.getFont(10)
        characterLimitLabel.font = characterLabelFont
        headerLabel.font = smallFont
        profileTextView.font = textfieldFont
        profileTextView.textColor =  UIColor.labelTextColor
        headerLabel.textColor = UIColor.labelTextColor
        profileTextView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0)
    }
    
}
