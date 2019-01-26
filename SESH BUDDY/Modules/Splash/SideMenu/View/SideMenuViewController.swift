//
//  SideMenuViewController.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 05/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//



import UIKit
import AlamofireImage
import Alamofire
enum SideMenuSections:Int {
    case home
    case deals
    case sessions
    case buddies
    case ratings
    case history
    case settings
    case count
}
class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var buddyProfileButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var userView: UIView!
    
    let sideMenuFieldTableViewCell = "SideMenuFieldTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUPUI()
    }
    func setUPUI() {
        self.userView.backgroundColor = .orange
        let font = Fonts.mavenProRegular.getFont(13)
        editProfileButton.titleLabel?.font = font
        userNameLabel.font = font
        userNameLabel.numberOfLines = 0
        editProfileButton.setTitleColor(.white, for: .normal)
        editProfileButton.setTitle("Edit Profile", for: .normal)
        userImageView.layer.cornerRadius =  userImageView.bounds.height / 2
        userImageView.image = Icons.profilePlaceHolder
        
        sideMenuTableView.registerCellFrom(sideMenuFieldTableViewCell)
        sideMenuTableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        guard ApplicationData.shared.checkLoginData(),  let userName = ApplicationData.shared.getLoginData().userName else {
            return
        }
        userNameLabel.text = userName
        if ApplicationData.shared.checkLoginData(), ApplicationData.shared.getLoginData().profilePic.count > 0 {
            let profilePic = ApplicationData.shared.getLoginData().profilePic
            let url = URL(string: profilePic!)
            userImageView.af_setImage(withURL: url!, placeholderImage: Icons.profilePlaceHolder, filter: nil, progress: nil, progressQueue: .main, imageTransition: .crossDissolve(0.1), runImageTransitionIfCached: true) { (nil) in
            }
        } else {
            userImageView.image = Icons.profilePlaceHolder
        }
    }
    
    
    @IBAction func buddyProfileButtonAction(_ sender: Any) {
        let editProfileViewController = BuddyProfileWireFrame.presentBuddyProfileModule()
        guard let nav = self.frostedViewController.contentViewController as? UINavigationController else {
            return
        }
        let navChild = nav.viewControllers
        if navChild.last is BuddyProfileViewController  {
            self.frostedViewController.hideMenuViewController()
        } else {
            self.frostedViewController.hideMenuViewController()
            DispatchQueue.main.async {
                nav.setViewControllers([editProfileViewController], animated: true)
            }
        }
    }
    @IBAction func userViewClicked(_ sender: Any) {
    }
    @IBAction func editProfileButtonAction(_ sender: Any) {
        let editProfileViewController = EditProfileWireFrame.createEditProfileModule()
        guard let nav = self.frostedViewController.contentViewController as? UINavigationController else {
            return
        }
        let navChild = nav.viewControllers
        if navChild.last is ProfileViewController  {
            self.frostedViewController.hideMenuViewController()
        } else {
            self.frostedViewController.hideMenuViewController()
            DispatchQueue.main.async {
                nav.setViewControllers([editProfileViewController], animated: true)
            }
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
        case .sessions:
            let settingsViewController = SessionsWireFrame.presentSessionsModule()
            guard let nav = self.frostedViewController.contentViewController as? UINavigationController else {
                return
            }
          
            let navChild = nav.viewControllers
            if navChild.last is SessionsViewController  {
                self.frostedViewController.hideMenuViewController()
            } else {
                self.frostedViewController.hideMenuViewController()
                DispatchQueue.main.async {
                    nav.setViewControllers([settingsViewController], animated: true)
                }
            }
           
        case .buddies:
            let settingsViewController = BuddiesWireFrame.presentBuddiesModule()
            guard let nav = self.frostedViewController.contentViewController as? UINavigationController else {
                return
            }
            
            let navChild = nav.viewControllers
            if navChild.last is BuddiesViewController  {
                self.frostedViewController.hideMenuViewController()
            } else {
                self.frostedViewController.hideMenuViewController()
                DispatchQueue.main.async {
                    nav.setViewControllers([settingsViewController], animated: true)
                }
            }
        case .ratings:
            let settingsViewController = RatingWireFrame.presentRatingModule()
            guard let nav = self.frostedViewController.contentViewController as? UINavigationController else {
                return
            }
            let navChild = nav.viewControllers
            if navChild.last is RatingViewController  {
                self.frostedViewController.hideMenuViewController()
            } else {
                self.frostedViewController.hideMenuViewController()
                DispatchQueue.main.async {
                    nav.setViewControllers([settingsViewController], animated: true)
                }
            }
        case .history:
            let settingsViewController = HistoryWireFrame.presentHistoryModule()
        guard let nav = self.frostedViewController.contentViewController as? UINavigationController else {
            return
        }
            let navChild = nav.viewControllers
            if navChild.last is HistoryViewController  {
                self.frostedViewController.hideMenuViewController()
            } else {
                self.frostedViewController.hideMenuViewController()
                DispatchQueue.main.async {
                    nav.setViewControllers([settingsViewController], animated: true)
                }
            }
        case .settings:
            let settingsViewController = SettingsWireFrame.createSettingsModule()
            guard let nav = self.frostedViewController.contentViewController as? UINavigationController else {
                return
            }
            let navChild = nav.viewControllers
            if navChild.last is SettingsViewController  {
                self.frostedViewController.hideMenuViewController()
            } else {
                self.frostedViewController.hideMenuViewController()
                DispatchQueue.main.async {
                    nav.setViewControllers([settingsViewController], animated: true)
                }
            }
        default: break
        }
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SideMenuFieldTableViewCell {
            cell.sideMenuFieldIcon.isHighlighted = true
            cell.sideMenuFieldName.textColor = .orange
            cell.bgView.backgroundColor = UIColor.backgroundGrey

        }
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SideMenuFieldTableViewCell {
            cell.sideMenuFieldIcon.isHighlighted = false
            cell.sideMenuFieldName.textColor = .black
            cell.bgView.backgroundColor = .sideMenuBackgroundColor

        }
    }
}

extension SideMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SideMenuSections.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
