//
//  TopSeshBuddiesViewController.swift
//  SESH BUDDY
//
//  Created by test on 05/12/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class TopSeshBuddiesViewController: UIViewController, TopBuddyViewProtocol {

    @IBOutlet weak var topBuddyCollectionView: UICollectionView!
    @IBOutlet weak var topBuddiesFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var averageRatingView: UIView!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var averageStarRatingView: FloatRatingView!
    @IBOutlet weak var qualityTitleLabel: UILabel!
    @IBOutlet weak var qualityRatingView: FloatRatingView!
    @IBOutlet weak var quantityTitleLabel: UILabel!
    @IBOutlet weak var quantityStarRatingView: FloatRatingView!
    @IBOutlet weak var rollsTitleLabel: UILabel!
    @IBOutlet weak var rollsStarRatingView: FloatRatingView!
    @IBOutlet weak var userCommentLabel: UILabel!
    let topSeshBuddiesCollectionViewCell = "TopSeshBuddiesCollectionViewCell"
    var presenter: TopBuddyPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStyle(.default)
        self.showMenuBarButton(false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        registerNib()
        setUPUI()
        self.setUPStarRating(isEditable: false)
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
        
        self.qualityTitleLabel.font = normalFont
        self.quantityTitleLabel.font = normalFont
        self.rollsTitleLabel.font = normalFont
        self.userCommentLabel.font = normalFont
        self.averageRatingLabel.font = boldFont
        
        self.qualityTitleLabel.textColor = color
        self.quantityTitleLabel.textColor = color
        self.userCommentLabel.textColor = color
        self.rollsTitleLabel.textColor = color
        self.averageRatingLabel.textColor = color
        
    }
    func setUPStarRating(isEditable: Bool) {
        self.averageRatingView.addShadow(0)
        self.averageRatingView.backgroundColor = UIColor.backgroundGrey
        self.averageStarRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.averageStarRatingView.maxRating = 4
        self.averageStarRatingView.minRating = 1
        self.averageStarRatingView.rating = 3
        self.averageStarRatingView.editable = isEditable
        self.averageStarRatingView.halfRatings = false
        self.averageStarRatingView.floatRatings = false
        self.averageStarRatingView.fullImage = Icons.starGreen
        self.averageStarRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
        self.averageRatingView.backgroundColor = UIColor.backgroundGrey
        self.qualityRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.qualityRatingView.maxRating = 4
        self.qualityRatingView.minRating = 1
        self.qualityRatingView.rating = 3
        self.qualityRatingView.editable = isEditable
        self.qualityRatingView.halfRatings = false
        self.qualityRatingView.floatRatings = false
        self.qualityRatingView.fullImage = Icons.starGreen
        self.qualityRatingView.emptyImage = Icons.starGray!.coloredImage(color: UIColor.backgroundDarkGrey)
        
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
    func registerNib() {
        topBuddyCollectionView.register(UINib(nibName: topSeshBuddiesCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: topSeshBuddiesCollectionViewCell)
        topBuddyCollectionView.delegate = self
        topBuddyCollectionView.dataSource = self        
    }
}
extension TopSeshBuddiesViewController: UICollectionViewDelegate {
    
}
extension TopSeshBuddiesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topSeshBuddiesCollectionViewCell, for: indexPath) as? TopSeshBuddiesCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
extension TopSeshBuddiesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 0.0
        let width = collectionView.frame.size.width
        return CGSize(width: (width - margin)/4, height: 185)
    }
}
