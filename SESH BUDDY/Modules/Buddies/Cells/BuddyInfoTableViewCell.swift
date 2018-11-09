//
//  BuddyInfoTableViewCell.swift
//  SESH BUDDY
//
//  Created by test on 13/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class BuddyInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var buddyImageView: UIImageView!
    @IBOutlet weak var buddyInfoView: UIView!
    @IBOutlet weak var qualityView: UIView!
    @IBOutlet weak var qualityRatingView: FloatRatingView!
    @IBOutlet weak var qualityLabel: UILabel!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var buddyStackView: UIStackView!
    @IBOutlet weak var rollsView: UIView!
    @IBOutlet weak var buddyTitileLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityRatingView: FloatRatingView!
    @IBOutlet weak var rollsLabel: UILabel!
    @IBOutlet weak var rollsRatingView: FloatRatingView!
    @IBOutlet weak var buddyCommentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUPUI()
        setUPStarRating()
    }
    func setUPUI(){
        buddyImageView.layer.borderColor = UIColor.backgroundHeaderGrey.cgColor
        buddyImageView.layer.borderWidth = 1.0
        self.backgroundColor = .clear
        let font = Fonts.mavenProRegular.getFont(12)
        let color = UIColor.themeDarkTextColor
        qualityLabel.font = font
        buddyTitileLabel.font = font
        quantityLabel.font = font
        rollsLabel.font = font
        buddyCommentLabel.font = font
        
        qualityLabel.textColor = color
        buddyTitileLabel.textColor = color
        quantityLabel.textColor = color
        rollsLabel.textColor = color
        buddyCommentLabel.textColor = color
        
        buddyImageView.layer.cornerRadius = buddyImageView.frame.size.height / 2
        buddyImageView.layer.masksToBounds = true
    }
    func setUPStarRating() {
        
        self.qualityRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.qualityRatingView.maxRating = 4
        self.qualityRatingView.minRating = 1
        self.qualityRatingView.rating = 3
        self.qualityRatingView.editable = true
        self.qualityRatingView.halfRatings = false
        self.qualityRatingView.floatRatings = false
        self.qualityRatingView.fullImage = Icons.starGreen
        self.qualityRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.quantityRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.quantityRatingView.maxRating = 4
        self.quantityRatingView.minRating = 1
        self.quantityRatingView.rating = 2
        self.quantityRatingView.editable = true
        self.quantityRatingView.halfRatings = false
        self.quantityRatingView.floatRatings = false
        self.quantityRatingView.fullImage = Icons.starGreen
        self.quantityRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.rollsRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.rollsRatingView.maxRating = 4
        self.rollsRatingView.minRating = 1
        self.rollsRatingView.rating = 4
        self.rollsRatingView.editable = true
        self.rollsRatingView.halfRatings = false
        self.rollsRatingView.floatRatings = false
        self.rollsRatingView.fullImage = Icons.starGreen
        self.rollsRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
    }
    
}
