//
//  BuddiesViewController.swift
//  SESH BUDDY
//
//  Created by test on 07/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class BuddiesViewController: UIViewController, BuddiesViewProtocol {
    
    var presenter: BuddiesPresenterProtocol?
    @IBOutlet weak var buddiesTableView: UITableView!
    
    let buddyInfoTableViewCell = "BuddyInfoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    func registerNib(){
        self.buddiesTableView.backgroundColor = UIColor.backgroundGrey
        buddiesTableView.registerCellFrom(buddyInfoTableViewCell)
        buddiesTableView.delegate = self
        buddiesTableView.dataSource = self
    }
}
extension BuddiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: buddyInfoTableViewCell) as? BuddyInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.setUPStarRating(isEditable: false)
        return cell
    }
    
    
}
extension BuddiesViewController: UITableViewDelegate {
    
}
