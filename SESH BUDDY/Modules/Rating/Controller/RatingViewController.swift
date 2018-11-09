//
//  RatingViewController.swift
//  SESH BUDDY
//
//  Created by test on 14/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController, RatingViewProtocol {
    
    @IBOutlet weak var averageRatingCommentLabel: UILabel!
    @IBOutlet weak var averageRollsFloatRatingView: FloatRatingView!
    @IBOutlet weak var averageRollsLabel: UILabel!
    @IBOutlet weak var averageQuantityFloatRatingView: FloatRatingView!
    @IBOutlet weak var averageQuantityLabel: UILabel!
    @IBOutlet weak var averageQualityFloatRatingView: FloatRatingView!
    @IBOutlet weak var averageQualityLabel: UILabel!
    @IBOutlet weak var averageRatingView: FloatRatingView!
    @IBOutlet weak var averageFloatRatingView: FloatRatingView!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var ratingContainerView: UIView!
    @IBOutlet weak var ratingTableView: UITableView!
    
    let buddyInfoTableViewCell = "BuddyInfoTableViewCell"
    var presenter: RatingPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStyle(.default)
        self.showMenuBarButton(true)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        registerNib()
        setUPUI()
        setUPStarRating()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavBarRightButton(type: .plus)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
    }
    
    func setUPUI(){
        let boldFont = Fonts.mavenProBold.getFont(16.0)
        let normalFont = Fonts.mavenProRegular.getFont(14.0)
        let color = UIColor.themeDarkTextColor
        
        self.averageQualityLabel.font = normalFont
        self.averageQuantityLabel.font = normalFont
        self.averageRollsLabel.font = normalFont
        self.averageRatingCommentLabel.font = normalFont
        self.averageRatingLabel.font = boldFont
        
        self.averageQualityLabel.textColor = color
        self.averageQuantityLabel.textColor = color
        self.averageRollsLabel.textColor = color
        self.averageRatingCommentLabel.textColor = color
        self.averageRatingLabel.textColor = color
        
    }
    func setUPStarRating() {
        self.averageRatingView.addShadow(0)
        self.averageRatingView.backgroundColor = UIColor.backgroundGrey
        self.averageFloatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.averageFloatRatingView.maxRating = 4
        self.averageFloatRatingView.minRating = 1
        self.averageFloatRatingView.rating = 3
        self.averageFloatRatingView.editable = true
        self.averageFloatRatingView.halfRatings = false
        self.averageFloatRatingView.floatRatings = false
        self.averageFloatRatingView.fullImage = Icons.starGreen
        self.averageFloatRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.averageRatingView.backgroundColor = UIColor.backgroundGrey
        self.averageQualityFloatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.averageQualityFloatRatingView.maxRating = 4
        self.averageQualityFloatRatingView.minRating = 1
        self.averageQualityFloatRatingView.rating = 3
        self.averageQualityFloatRatingView.editable = true
        self.averageQualityFloatRatingView.halfRatings = false
        self.averageQualityFloatRatingView.floatRatings = false
        self.averageQualityFloatRatingView.fullImage = Icons.starGreen
        self.averageQualityFloatRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.averageQuantityFloatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.averageQuantityFloatRatingView.maxRating = 4
        self.averageQuantityFloatRatingView.minRating = 1
        self.averageQuantityFloatRatingView.rating = 2
        self.averageQuantityFloatRatingView.editable = true
        self.averageQuantityFloatRatingView.halfRatings = false
        self.averageQuantityFloatRatingView.floatRatings = false
        self.averageQuantityFloatRatingView.fullImage = Icons.starGreen
        self.averageQuantityFloatRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.averageRollsFloatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.averageRollsFloatRatingView.maxRating = 4
        self.averageRollsFloatRatingView.minRating = 1
        self.averageRollsFloatRatingView.rating = 4
        self.averageRollsFloatRatingView.editable = true
        self.averageRollsFloatRatingView.halfRatings = false
        self.averageRollsFloatRatingView.floatRatings = false
        self.averageRollsFloatRatingView.fullImage = Icons.starGreen
        self.averageRollsFloatRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
    }
    func registerNib(){
        self.ratingTableView.backgroundColor = UIColor.backgroundGrey
        ratingTableView.registerCellFrom(buddyInfoTableViewCell)
        ratingTableView.delegate = self
        ratingTableView.dataSource = self
    }
}
extension RatingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: buddyInfoTableViewCell) as? BuddyInfoTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
}
extension RatingViewController: UITableViewDelegate {
    
}
