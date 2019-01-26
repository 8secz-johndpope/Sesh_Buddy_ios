//
//  BuddyInfoTableViewCell.swift
//  SESH BUDDY
//
//  Created by test on 13/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class BuddyInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var characterLimitLabel: UILabel!
    @IBOutlet weak var textviewBottomView: UIView!
    @IBOutlet weak var bottomConstraintOfBgView: NSLayoutConstraint!
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
    @IBOutlet weak var buddyCommentTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUPUI()
    }
    func setUPUI(){
        characterLimitLabel.font = Fonts.mavenProRegular.getFont(10)
        buddyImageView.layer.borderColor = UIColor.backgroundHeaderGrey.cgColor
        buddyImageView.layer.borderWidth = 1.0
        self.backgroundColor = .clear
        placeHolderLabel.font = Fonts.mavenProRegular.getFont(13)
        placeHolderLabel.textColor = UIColor.lightGray
        characterLimitLabel.textColor = UIColor.lightGray
        let font = Fonts.mavenProRegular.getFont(13)
        let color = UIColor.themeDarkTextColor
        qualityLabel.font = font
        buddyTitileLabel.font = font
        quantityLabel.font = font
        rollsLabel.font = font
        buddyCommentTextView.font = font
        
        qualityLabel.textColor = color
        buddyTitileLabel.textColor = color
        quantityLabel.textColor = color
        rollsLabel.textColor = color
        buddyCommentTextView.textColor = color
        
        buddyImageView.layer.cornerRadius = buddyImageView.frame.size.height / 2
        buddyImageView.layer.masksToBounds = true
    }
    func setUPStarRating(isEditable:Bool) {
        
        self.qualityRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.qualityRatingView.maxRating = 4
        self.qualityRatingView.minRating = 0
        self.qualityRatingView.rating = 3
        self.qualityRatingView.editable = isEditable
        self.qualityRatingView.halfRatings = false
        self.qualityRatingView.floatRatings = false
        self.qualityRatingView.fullImage = Icons.starGreen
        self.qualityRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.quantityRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.quantityRatingView.maxRating = 4
        self.quantityRatingView.minRating = 0
        self.quantityRatingView.rating = 2
        self.quantityRatingView.editable = isEditable
        self.quantityRatingView.halfRatings = false
        self.quantityRatingView.floatRatings = false
        self.quantityRatingView.fullImage = Icons.starGreen
        self.quantityRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.rollsRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.rollsRatingView.maxRating = 4
        self.rollsRatingView.minRating = 0
        self.rollsRatingView.rating = 4
        self.rollsRatingView.editable = isEditable
        self.rollsRatingView.halfRatings = false
        self.rollsRatingView.floatRatings = false
        self.rollsRatingView.fullImage = Icons.starGreen
        self.rollsRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        self.buddyCommentTextView.tintColor = UIColor.themeNavBarColor
        self.textviewBottomView.backgroundColor = UIColor.themeNavBarColor
        if isEditable == true {
            self.textviewBottomView.isHidden = false
            self.textviewBottomView.backgroundColor = UIColor.themeNavBarColor
        } else {
            self.textviewBottomView.isHidden = true
        }
        self.buddyCommentTextView.isUserInteractionEnabled = isEditable
        if isEditable ==  false {
            placeHolderLabel.isHidden = true
            placeHolderLabel.text = ""
            characterLimitLabel.isHidden = true
            characterLimitLabel.text = ""
        } else {
            placeHolderLabel.text = "Please enter comment"
        }
    }
    
    func setUPDetails(from: SeshBuddies) {
        self.qualityRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.qualityRatingView.maxRating = 4
        self.qualityRatingView.minRating = 0
        self.qualityRatingView.rating = from.qualityRating.floatValue
        self.qualityRatingView.halfRatings = false
        self.qualityRatingView.floatRatings = false
        self.qualityRatingView.fullImage = Icons.starGreen
        self.qualityRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.quantityRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.quantityRatingView.maxRating = 4
        self.quantityRatingView.minRating = 0
        self.quantityRatingView.rating = from.quantityRating.floatValue
        self.quantityRatingView.halfRatings = false
        self.quantityRatingView.floatRatings = false
        self.quantityRatingView.fullImage = Icons.starGreen
        self.quantityRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.rollsRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.rollsRatingView.maxRating = 4
        self.rollsRatingView.minRating = 0
        self.rollsRatingView.rating = from.rollsRating.floatValue
        self.rollsRatingView.halfRatings = false
        self.rollsRatingView.floatRatings = false
        self.rollsRatingView.fullImage = Icons.starGreen
        self.rollsRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        self.buddyCommentTextView.text = from.comment
      
    }
    
}
