//
//  SideMenuViewController.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 05/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//



import UIKit
enum SideMenuSections:Int {
    case home
    case deals
    case sessions
    case buddies
    case ratings
    case history
    case settings
    case logout
    case count
}
class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var versionButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var userView: UIView!
    
    let sideMenuFieldTableViewCell = "SideMenuFieldTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
    }

    func setUPUI() {
        self.userView.backgroundColor = .orange
        let font = Fonts.mavenProRegular.getFont(11)
        editProfileButton.titleLabel?.font = font
        versionButton.titleLabel?.font = font
        editProfileButton.setTitleColor(.white, for: .normal)
        editProfileButton.setTitle("Edit Profile", for: .normal)
        versionButton.setTitle("9080fish", for: .normal)
        versionButton.setTitleColor(.white, for: .normal)
        userImageView.layer.cornerRadius =  userImageView.bounds.height / 2
        userImageView.image = Icons.profilePlaceHolder
        
        sideMenuTableView.registerCellFrom(sideMenuFieldTableViewCell)
        
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
    }
    
    @IBAction func userViewClicked(_ sender: Any) {
    }
    @IBAction func editProfileButtonAction(_ sender: Any) {
        let editProfileViewController = EditProfileWireFrame.createEditProfileModule()
        guard let nav = self.frostedViewController.contentViewController as? UINavigationController else {
            return
        }
        self.frostedViewController.hideMenuViewController()
        DispatchQueue.main.async {
            nav.pushViewController(editProfileViewController, animated: true)
        }
        
        
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let enumVal = SideMenuSections.init(rawValue: indexPath.section) else {
            return
        }
        switch enumVal {
        case .home:
            guard let nav = self.frostedViewController.contentViewController as? UINavigationController, nav.viewControllers.count > 0  else {
                self.frostedViewController.hideMenuViewController()
                return
            }
            let navChild = nav.viewControllers
            if navChild.last is HomeViewController  {
                self.frostedViewController.hideMenuViewController()
            } else {
                
                if let index = navChild.index(where: { (element) -> Bool in
                    return element.classForCoder is HomeViewController.Type
                }), index != NSNotFound {
                    self.frostedViewController.hideMenuViewController()
                    DispatchQueue.main.async {
                        nav.popToViewController(navChild[index], animated: true)
                    }
                } else {
                    self.frostedViewController.hideMenuViewController()
                    DispatchQueue.main.async {
                        appDelegate.changeVisibleRootController(Storyboards.homeFlow.getHomeScreen())
                    }
                }
            }
        case .deals: break
        case .sessions: break
        case .buddies: break
        case .ratings: break
        case .history: break
        case .settings:
            let settingsViewController = SettingsWireFrame.createSettingsModule()
            guard let nav = self.frostedViewController.contentViewController as? UINavigationController else {
                return
            }
            self.frostedViewController.hideMenuViewController()
            DispatchQueue.main.async {
                nav.pushViewController(settingsViewController, animated: true)
            }
        case .logout: break
        default: break
        }
    }
}

extension SideMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SideMenuSections.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SideMenuSections.count.rawValue {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: sideMenuFieldTableViewCell) as? SideMenuFieldTableViewCell else {
            return UITableViewCell()
        }
        guard let enumVal = SideMenuSections.init(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
      cell.setCellValue(type: enumVal)
        return cell
    }
    
    
}
