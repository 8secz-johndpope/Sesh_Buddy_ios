//
//  AverageRatingTableViewCell.swift
//  SESH BUDDY
//
//  Created by test on 08/12/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class AverageRatingTableViewCell: UITableViewCell {
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var averageFloatRatingView: FloatRatingView!
    @IBOutlet weak var quantityTitleLabel: UILabel!
    @IBOutlet weak var rollsTitleLabel: UILabel!
    @IBOutlet weak var qualityTitleLabel: UILabel!
    @IBOutlet weak var rollsStarRatingView: FloatRatingView!
    @IBOutlet weak var ommentLabel: UILabel!
    @IBOutlet weak var qualityStarRatingView: FloatRatingView!
    @IBOutlet weak var quantityStarRatingView: FloatRatingView!
    
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUPUI()
        self.setUPStarRating(isEditable: false)
    }
    func setUPUI(){
        let boldFont = Fonts.mavenProBold.getFont(16.0)
        let normalFont = Fonts.mavenProRegular.getFont(14.0)
        let color = UIColor.themeDarkTextColor
        
        self.qualityTitleLabel.font = normalFont
        self.quantityTitleLabel.font = normalFont
        self.rollsTitleLabel.font = normalFont
        self.ommentLabel.font = normalFont
        self.averageRatingLabel.font = boldFont
        
        self.qualityTitleLabel.textColor = color
        self.quantityTitleLabel.textColor = color
        self.ommentLabel.textColor = color
        self.rollsTitleLabel.textColor = color
        self.averageRatingLabel.textColor = color
        
    }
    func setUPStarRating(isEditable: Bool) {
        self.bgView.addShadow(0)
        self.averageFloatRatingView.backgroundColor = UIColor.backgroundGrey
        self.averageFloatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.averageFloatRatingView.maxRating = 4
        self.averageFloatRatingView.minRating = 1
        self.averageFloatRatingView.rating = 3
        self.averageFloatRatingView.editable = isEditable
        self.averageFloatRatingView.halfRatings = false
        self.averageFloatRatingView.floatRatings = false
        self.averageFloatRatingView.fullImage = Icons.starGreen
        self.averageFloatRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.qualityStarRatingView.backgroundColor = UIColor.backgroundGrey
        self.qualityStarRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.qualityStarRatingView.maxRating = 4
        self.qualityStarRatingView.minRating = 1
        self.qualityStarRatingView.rating = 3
        self.qualityStarRatingView.editable = isEditable
        self.qualityStarRatingView.halfRatings = false
        self.qualityStarRatingView.floatRatings = false
        self.qualityStarRatingView.fullImage = Icons.starGreen
        self.qualityStarRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.quantityStarRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.quantityStarRatingView.maxRating = 4
        self.quantityStarRatingView.minRating = 1
        self.quantityStarRatingView.rating = 2
        self.quantityStarRatingView.editable = isEditable
        self.quantityStarRatingView.halfRatings = false
        self.quantityStarRatingView.floatRatings = false
        self.quantityStarRatingView.fullImage = Icons.starGreen
        self.quantityStarRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.rollsStarRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.rollsStarRatingView.maxRating = 4
        self.rollsStarRatingView.minRating = 1
        self.rollsStarRatingView.rating = 4
        self.rollsStarRatingView.editable = isEditable
        self.rollsStarRatingView.halfRatings = false
        self.rollsStarRatingView.floatRatings = false
        self.rollsStarRatingView.fullImage = Icons.starGreen
        self.rollsStarRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
