//
//  BuddyProfileViewController.swift
//  SESH BUDDY
//
//  Created by test on 08/12/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

enum BuddyProfileSection:Int {
    case buddyInfo
    case averageRating
    case rating
    case viewAllRating
    case topSeshBuddies
    case count
}

import UIKit

class BuddyProfileViewController: UIViewController, BuddyProfileViewProtocol {
    
    

    @IBOutlet weak var buddyTableView: UITableView!
    let profileInfoTableViewCell = "ProfileInfoTableViewCell"
    let averageRatingTableViewCell = "AverageRatingTableViewCell"
    let buddyInfoTableViewCell = "BuddyInfoTableViewCell"
    let labelTableViewCell = "LabelTableViewCell"
    var profileImage: UIImage!
    var coverImage: UIImage!
    var selectedImageType: ImageType!
    var presenter: BuddyProfilePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        SelectImage.sharedInstance.delegate = self
        self.changeStyle(.default)
        self.showMenuBarButton(true)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        registerNib()
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
    func registerNib() {
        self.buddyTableView.backgroundColor = UIColor.backgroundGrey
        buddyTableView.registerCellFrom(profileInfoTableViewCell)
        buddyTableView.registerCellFrom(averageRatingTableViewCell)
        buddyTableView.registerCellFrom(buddyInfoTableViewCell)
        buddyTableView.registerCellFrom(labelTableViewCell)
        buddyTableView.delegate = self
        buddyTableView.dataSource = self
    }
    
    @objc func editProfileImageButtonAction() {
        selectedImageType = ImageType.profile
        SelectImage.sharedInstance.selectImage(self, folderPath: "", fileName: "")
    }
    
    @objc func editProfileBackgroundButtonAction() {
        selectedImageType = ImageType.backgroundProfile
        SelectImage.sharedInstance.selectImage(self, folderPath: "", fileName: "")
    }
    func onError(value: String) {
        UIAlertController.presentAlert(title: nil, message: value, style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
    }
    
    func showAlert(_ string: String) {
        UIAlertController.presentAlert(title: nil, message: string, style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
    }
    
    func reloadView() {
        self.buddyTableView.reloadData()
    }
}
extension BuddyProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let enumVal = BuddyProfileSection.init(rawValue: indexPath.section) else {
            return
        }
        
        switch enumVal {
        case .viewAllRating:
            self.presenter?.moveToViewAllRatings()
        case .topSeshBuddies:
            self.presenter?.moveToTopSeshBuddies()
        default:
            break
        }
        
    }
}
extension BuddyProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return BuddyProfileSection.count.rawValue
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let enumVal = BuddyProfileSection.init(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch enumVal {
        case .buddyInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: profileInfoTableViewCell) as? ProfileInfoTableViewCell else {
                return UITableViewCell()
            }
            if ApplicationData.shared.checkLoginData(), ApplicationData.shared.getLoginData().profilePic.count > 0 {
                let profilePic = ApplicationData.shared.getLoginData().profilePic
                let url = URL(string: profilePic!)
                cell.profileImageView.af_setImage(withURL: url!, placeholderImage: Icons.profilePlaceHolder, filter: nil, progress: nil, progressQueue: .main, imageTransition: .crossDissolve(0.1), runImageTransitionIfCached: true) { (nil) in
                }
            } else {
                cell.profileImageView.image = Icons.profilePlaceHolder
            }
            
            if ApplicationData.shared.checkLoginData(), ApplicationData.shared.getLoginData().coverPic.count > 0 {
                cell.descriptionTextView.text = ApplicationData.shared.getLoginData().aboutMe
                let profilePic = ApplicationData.shared.getLoginData().coverPic
                let url = URL(string: profilePic!)
                cell.bgImageView.af_setImage(withURL: url!, placeholderImage: Icons.splash, filter: nil, progress: nil, progressQueue: .main, imageTransition: .crossDissolve(0.1), runImageTransitionIfCached: true) { (nil) in
                }
            } else {
                cell.descriptionTextView.text = ""
                cell.bgImageView.image = Icons.splash
            }
            cell.editProfileImageButton.addTarget(self, action: #selector(self.editProfileImageButtonAction), for: .touchUpInside)
            cell.editDescriptionButton.addTarget(self, action: #selector(self.editProfileBackgroundButtonAction), for: .touchUpInside)
            return cell
        case .averageRating:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: averageRatingTableViewCell) as? AverageRatingTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case .rating:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: buddyInfoTableViewCell) as? BuddyInfoTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.setUPStarRating(isEditable: false)
            return cell
        case .viewAllRating:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: labelTableViewCell) as? LabelTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.descLabel.text = "View All Ratings"
            cell.hideToogleButton(value: true)
            return cell
        case .topSeshBuddies:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: labelTableViewCell) as? LabelTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.descLabel.text = "Top Sesh Buddies"
            cell.hideToogleButton(value: true)
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    
}
extension BuddyProfileViewController: SavedImageDelegate {
    func imageSelectedSuccesfully(_ filePath: String, image: UIImage) {
        if selectedImageType == .profile {
            self.profileImage = image
            self.presenter?.updatePictureClick(image: image, type: .profile)//editProfileImage(image: self.profileImage, type: .profile)
        } else {
            self.coverImage = image
            self.presenter?.updatePictureClick(image: image, type: .backgroundProfile)
        }
        self.buddyTableView.reloadData()
    }
}
