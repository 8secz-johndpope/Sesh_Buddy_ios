//
//  SideMenuFieldTableViewCell.swift
//  Jugnoo Driver
//
//  Created by Divyansh Bhardwaj on 27/04/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import UIKit

class SideMenuFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var sideMenuFieldIcon: UIImageView!
    @IBOutlet weak var sideMenuFieldName: UILabel!
    @IBOutlet weak var bottomLineView: UIView!

    private let fieldNameSize: CGFloat = CGFloat(16)
    var isSwitchEnabled = false
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpUI() {
        self.bgView.backgroundColor = .sideMenuBackgroundColor
        self.sideMenuFieldName.font = Fonts.mavenProRegular.getFont(fieldNameSize)
        self.sideMenuFieldName.textColor = .black
        self.sideMenuFieldName.isUserInteractionEnabled = false
    }
    
    func setCellValue(type: SideMenuSections) {
        switch type {
        case .home:
            sideMenuFieldName.text = "Home"
            sideMenuFieldIcon.image = Icons.home
        case .deals:
            sideMenuFieldName.text = "Deals"
            sideMenuFieldIcon.image = Icons.deal
        case .sessions:
            sideMenuFieldName.text = "Seshsions"
            sideMenuFieldIcon.image = Icons.session
        case .buddies:
            sideMenuFieldName.text = "Buddies"
            sideMenuFieldIcon.image = Icons.buddies
        case .ratings:
            sideMenuFieldName.text = "Ratings"
            sideMenuFieldIcon.image = Icons.rating
        case .history:
            sideMenuFieldName.text = "History"
            sideMenuFieldIcon.image = Icons.history
        case .settings:
            sideMenuFieldName.text = "Settings"
            sideMenuFieldIcon.image = Icons.setting
        default:
            break
        }
        
        
    }
    
}
