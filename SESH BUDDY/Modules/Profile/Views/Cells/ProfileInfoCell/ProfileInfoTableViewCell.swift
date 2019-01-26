//
//  ProfileInfoTableViewCell.swift
//  SESH BUDDY
//
//  Created by Apple on 12/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var editProfileImageButton: UIButton!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var editDescriptionButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionTextView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2
        let font = Fonts.mavenProRegular.getFont(14)
        profileLabel.font = font
        profileLabel.text = ApplicationData.shared.getLoginData().userName
        self.descriptionTextView.isEditable = false
        self.descriptionTextView.isSelectable = false
    }

}
