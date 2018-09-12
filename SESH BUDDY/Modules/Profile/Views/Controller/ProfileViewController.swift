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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension ProfileViewController: UITableViewDelegate {
    
}
