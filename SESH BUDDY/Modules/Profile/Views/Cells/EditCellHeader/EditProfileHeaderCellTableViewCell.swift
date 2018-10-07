//
//  EditProfileHeaderCellTableViewCell.swift
//  SESH BUDDY
//
//  Created by Apple on 12/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class EditProfileHeaderCellTableViewCell: UITableViewCell {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headerButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.backgroundColor = UIColor.backgroundGrey
        let textfieldFont = Fonts.mavenProRegular.getFont(14)
        headerLabel.font = textfieldFont
        
    }
 }
