//
//  SessionDetailsTableViewCell.swift
//  SESH BUDDY
//
//  Created by test on 20/11/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class SessionDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLAbel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var rightLAbel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUPUI()
    }
    func setUPUI(){
        let font = Fonts.mavenProRegular.getFont(14)
        let color = UIColor.white
        leftLAbel.font = font
        leftLAbel.textColor = color
        rightLAbel.font = font
        rightLAbel.textColor = color
        
    }
    func setUPData(info: SeshData) {
        guard let key = info.key,  !key.isEmpty else {
            return
        }
        guard let value = info.value,  !value.isEmpty else {
            return
        }
        self.leftLAbel.text = key
        self.rightLAbel.text = value
        
    }

    
}
