//
//  SessionTypeTableViewCell.swift
//  SESH BUDDY
//
//  Created by test on 29/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class SessionTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var addOrRemoveButton: UIButton!
    @IBOutlet weak var headeLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headerTileLabel: UILabel!
    @IBOutlet weak var sessionTypeButton: UIButton!
    @IBOutlet weak var dropDownImageView: UIImageView!
    @IBOutlet weak var sessionTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        setUPUI()
    }
    
    func setUPUI(){
        headerTileLabel.textColor = UIColor.white
        headerTileLabel.font = Fonts.mavenProRegular.getFont(13)
        let font = Fonts.mavenProMedium.getFont(15)
        sessionTextField.font = Fonts.mavenProRegular.getFont(15)
        sessionTypeButton.titleLabel?.font =  font
        sessionTypeButton.setTitleColor(UIColor.white, for: .normal)
        dropDownImageView.image = Icons.dropDown?.coloredImage(color: .white)
        sessionTypeButton.layer.borderColor = UIColor.white.cgColor
        sessionTypeButton.layer.borderWidth = 1
        sessionTypeButton.backgroundColor = .clear
        sessionTextField.layer.borderColor = UIColor.white.cgColor
        sessionTextField.layer.borderWidth = 1
    }
    func setHeader(type: HomeViewSections){
        sessionTextField.isHidden = true
        sessionTypeButton.isHidden = true
        headerTileLabel.isHidden = false
        headeLabelBottomConstraint.constant = 20
        addOrRemoveButton.isHidden = true
        switch type {
        case .seshType:
            headerTileLabel.text = AppStrings.sesh_type.localized
            sessionTextField.isHidden = false
            sessionTypeButton.isHidden = true
            dropDownImageView.isHidden = false
        case .point:
            headerTileLabel.text = AppStrings.point.localized
            sessionTextField.isHidden = false
            sessionTypeButton.isHidden = true
            dropDownImageView.isHidden = false
        case .strain:
            headerTileLabel.text = AppStrings.straint.localized
            sessionTextField.isHidden = false
            sessionTypeButton.isHidden = true
            dropDownImageView.isHidden = false
        case .time:
            headerTileLabel.text = AppStrings.time.localized
            sessionTextField.isHidden = false
            sessionTypeButton.isHidden = true
            dropDownImageView.isHidden = true
        case .location:
            headerTileLabel.text = AppStrings.location.localized
            sessionTextField.isHidden = false
            sessionTypeButton.isHidden = true
            dropDownImageView.isHidden = true
        case .utensils:
            headerTileLabel.text = AppStrings.utensils.localized
            sessionTextField.isHidden = false
            sessionTypeButton.isHidden = true
            dropDownImageView.isHidden = false
        case .buddiesList:
            headerTileLabel.text = AppStrings.buddies.localized
            sessionTextField.isHidden = false
            sessionTypeButton.isHidden = true
            dropDownImageView.isHidden = true
            addOrRemoveButton.isHidden = false
            headerTileLabel.isHidden = false
            addOrRemoveButton.setImage(Icons.delete, for: .normal)
        case .gram:
            headerTileLabel.text = AppStrings.gram.localized
            sessionTextField.isHidden = false
            sessionTypeButton.isHidden = true
            dropDownImageView.isHidden = false
        case .reason:
            headerTileLabel.text = AppStrings.reason.localized
            sessionTextField.isHidden = false
            sessionTypeButton.isHidden = true
            dropDownImageView.isHidden = false
        case .date:
            headerTileLabel.text = AppStrings.date.localized
            sessionTextField.isHidden = false
            sessionTypeButton.isHidden = true
            dropDownImageView.isHidden = true
        default:
            break
        }
    }
    
}
