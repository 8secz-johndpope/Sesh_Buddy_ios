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
    }

    
}
