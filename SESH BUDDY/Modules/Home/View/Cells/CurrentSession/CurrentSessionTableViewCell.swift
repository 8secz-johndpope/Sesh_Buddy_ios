//
//  CurrentSessionTableViewCell.swift
//  SESH BUDDY
//
//  Created by test on 07/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class CurrentSessionTableViewCell: UITableViewCell {
    @IBOutlet weak var sessionEndButton: UIButton!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.bgView.backgroundColor = .clear
        self.sessionLabel.backgroundColor = .clear
        self.selectionStyle = .none
        setUPUI()
    }
    
    func setUPUI(){
        self.sessionEndButton.backgroundColor = UIColor.themeRed
    }
    func setSessionDetails(type: SessionType, text: String) {
        
        let firstString = text
        var secondString = ""
        let thirdString = " " + "in Sesh"
        
        switch type {
        case .SHMOKE:
            secondString = "SHMOKE"
            
        case .DROP:
            secondString = "DROP"
            
        case .MATCH:
            secondString = "MATCH"
            
        case .SMO:
            secondString = "SMO"
            
        default:
            break
        }
        secondString = " " +  secondString
        let firstAttributtedString = NSMutableAttributedString(string: firstString)
    firstAttributtedString.font(Fonts.mavenProRegular.getFont(13)).underline().color(UIColor.white)
        
        let secondAttributtedString = NSMutableAttributedString(string: secondString)
        secondAttributtedString.font(Fonts.mavenProBold.getFont(13)).color(UIColor.white)
        
        let thirdAttibutedString = NSMutableAttributedString(string: thirdString)
        thirdAttibutedString.font(Fonts.mavenProRegular.getFont(13)).color(UIColor.white)
        self.sessionLabel.attributedText = firstAttributtedString + secondAttributtedString + thirdAttibutedString
    }
}
