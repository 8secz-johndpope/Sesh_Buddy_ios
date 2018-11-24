//
//  EditProfileInputTableViewCell.swift
//  SESH BUDDY
//
//  Created by Apple on 12/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class EditProfileInputTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var profileTextField: UITextField!
    @IBOutlet weak var sepratorView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        sepratorView.backgroundColor = UIColor.backgroundGrey
        setUPUI()
    }

    func setUPUI(){
        let smallFont = Fonts.mavenProRegular.getFont(11)
        let textfieldFont = Fonts.mavenProRegular.getFont(14)
        headerLabel.font = smallFont
        profileTextField.font = textfieldFont
        profileTextField.textColor =  UIColor.labelTextColor
        headerLabel.textColor = UIColor.labelTextColor
    }
    
    func setCellValue(type: PersonalInfoSection) {
        switch type {
        case .firstName:
            headerLabel.text = "First Name:"
            profileTextField.text = "Hello"
        case .lastName:
            headerLabel.text = "Last Name:"
            profileTextField.text = "World"
        case .dateOfBirth:
            headerLabel.text = "Date Of Birth:"
        case .gender:
            headerLabel.text = "Gender:"
        default:
            break
        }
    }

    func setAccountDetails(type: AccountDetailsSection) {
        switch type {
        case .userName:
            profileTextField.isUserInteractionEnabled = true
            headerLabel.text = "Username:"
            profileTextField.text = "90805fish"
        case .favoritShope:
            profileTextField.isUserInteractionEnabled = true
            headerLabel.text = "Favourit Strain:"
            profileTextField.text = "Elchpoog"
        case .emailAddress:
            profileTextField.isUserInteractionEnabled = false
            headerLabel.text = "Email Address:"
            profileTextField.text = "sesh@seshbuddies.com"
        default:
            break
        }
    }
}
