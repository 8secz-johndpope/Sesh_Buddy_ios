//
//  TopSeshBuddiesCollectionViewCell.swift
//  SESH BUDDY
//
//  Created by test on 05/12/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class TopSeshBuddiesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userIDLabel: UILabel!
    
    @IBOutlet weak var statusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         self.bgView.backgroundColor = UIColor.backgroundGrey
        
    }

}
