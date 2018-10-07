//
//  StatusPopUpView.swift
//  SESH BUDDY
//
//  Created by Apple on 13/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

protocol StatusPopUpProtocol {
    func changeStatus(to: StatusTypes)
}

import UIKit

class StatusPopUpView: UIView {

    @IBOutlet weak var redUpView: UIView!
    @IBOutlet weak var holdingView: UIView!
    @IBOutlet weak var dryView: UIView!
    @IBOutlet weak var redUPRightLabel: UILabel!
    @IBOutlet weak var redUPLeftLabel: UILabel!
    @IBOutlet weak var redUPButton: UIButton!
    @IBOutlet weak var holdingRightLAbel: UILabel!
    @IBOutlet weak var holdingLeftLabel: UILabel!
    @IBOutlet weak var holdingButton: UIButton!
    @IBOutlet weak var dryLeftLabel: UILabel!
    @IBOutlet weak var dryRightLabel: UILabel!
    @IBOutlet weak var dryButton: UIButton!
    @IBOutlet weak var redUPImageButton: UIButton!
    @IBOutlet weak var holdingImageButton: UIButton!
    @IBOutlet weak var dryImageButton: UIButton!
    
    var source:UIViewController?
    let redUPString = "RE'D UP"
    let holdingString = "HOLDING"
    let dryString = "DRY"
    
    let redUPRightString = "SMOKE OR MATCH WITH BUDDIES"
    let holdingRightString = "DROP INS WITH BUDDIES"
    let dryRightString = "ASK BUDDIES TO SMO"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUPUI()
    }
    
    func setUPUI() {
        redUPImageButton.setImage(Icons.plus_green, for: .normal)
        holdingImageButton.setImage(Icons.plus_brown, for: .normal)
        dryImageButton.setImage(Icons.plus_black, for: .normal)
        
        let leftLAbelFont = Fonts.mavenProMedium.getFont(16)
        let rightLabelFont = Fonts.mavenProMedium.getFont(14)
        
        redUPLeftLabel.text = redUPString
        redUPLeftLabel.font = leftLAbelFont
        redUPRightLabel.text = redUPRightString
        redUPRightLabel.font = rightLabelFont
        redUPLeftLabel.textColor = UIColor.themeNavBarColor
        redUPRightLabel.textColor = UIColor.themeNavBarColor
        
        holdingLeftLabel.text = holdingString
        holdingLeftLabel.font = leftLAbelFont
        holdingRightLAbel.text = holdingRightString
        holdingRightLAbel.font = rightLabelFont
        holdingLeftLabel.textColor = UIColor.brown
        holdingRightLAbel.textColor = UIColor.brown
        
        dryLeftLabel.text = dryString
        dryLeftLabel.font = leftLAbelFont
        dryRightLabel.text = dryRightString
        dryRightLabel.font = rightLabelFont
        dryRightLabel.textColor = UIColor.profileBlackTextColor
        dryLeftLabel.textColor = UIColor.profileBlackTextColor
    }
    
    @IBAction func dryButtonAction(_ sender: Any) {
       source?.changerightNavBarButton(type: .dry)
    }
    @IBAction func holdingButtonAction(_ sender: Any) {
        source?.changerightNavBarButton(type: .holding)
    }
    @IBAction func redUPButtonAction(_ sender: Any) {
      source?.changerightNavBarButton(type: .redUP)
    }
    

}
