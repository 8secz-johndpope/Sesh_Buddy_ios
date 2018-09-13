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

enum AccountDetailsSection: Int {
    case userName
    case favoritShope
    case emailAddress
    case count
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
        guard let enumVal = ProfileSections.init(rawValue: section) else {
            return 0
        }
        switch enumVal {
        case .profileInfo:
            return 1
        case  .personalInfo:
            return PersonalInfoSection.count.rawValue
        case .accountDetails:
            return AccountDetailsSection.count.rawValue
        case .logout:
            return 0
        default:
            return 0
        }
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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: editProfileInputTableViewCell) as? EditProfileInputTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            case .lastName:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: editProfileInputTableViewCell) as? EditProfileInputTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            case .dateOfBirth:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: editProfileInputTableViewCell) as? EditProfileInputTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            case .gender:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: editProfileInputTableViewCell) as? EditProfileInputTableViewCell else {
                    return UITableViewCell()
                }
                return cell
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
