//
//  ProfileViewController.swift
//  SESH BUDDY
//
//  Created by Apple on 12/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit
enum ProfileSections:Int {
    case profileInfo
    case personalInfo
    case accountDetails
    case logout
    case count
}

enum PersonalInfoSection: Int {
    case firstName
    case lastName
    case dateOfBirth
    case gender
    case aboutMe
    case count
}

enum accountDetailsSection {
    case userName
    case favoritShope
    case emailAddress
}

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileTableView: UITableView!
     var presenter: EditProfilePresenterProtocol?
    
    let editProfileHeaderCellTableViewCell = "EditProfileHeaderCellTableViewCell"
    let textViewTableViewCell = "TextViewTableViewCell"
    let editProfileInputTableViewCell = "EditProfileInputTableViewCell"
    let profileInfoTableViewCell = "ProfileInfoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStyle(.default)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setUPUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
    }
    
    func setUPUI(){
        self.profileTableView.registerCellFrom(editProfileInputTableViewCell)
        self.profileTableView.registerCellFrom(textViewTableViewCell)
        self.profileTableView.registerCellFrom(editProfileInputTableViewCell)
         self.profileTableView.registerCellFrom(profileInfoTableViewCell)
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        
    }

}
extension ProfileViewController: EditProfileViewProtocol {
    func onError(value: String) {
        
    }
    func showAlert(_ string: String) {
        
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSections.count.rawValue
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let enumVal = ProfileSections.init(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch enumVal {
        case .profileInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: profileInfoTableViewCell) as? ProfileInfoTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .personalInfo:
            guard let rowVal = PersonalInfoSection.init(rawValue: indexPath.row) else {
                return UITableViewCell()
            }
            switch rowVal {
            case .firstName:
                break
            case .lastName:
                break
            case .dateOfBirth:
                break
            case .gender:
                break
            default:
                break
            }
            
        case .accountDetails:
            break
        case .logout:
            break
        default:
            break
        }
        
        return UITableViewCell()
    }
}

extension ProfileViewController: UITableViewDelegate {
    
}
