//
//  NotificationsViewController.swift
//  SESH BUDDY
//
//  Created by Apple on 12/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit
enum Notifications:Int {
    case shmoke
    case motch
    case drop
    case smo
    case deals
    case smoIous
    case count
}
class NotificationsViewController: UIViewController {

    @IBOutlet weak var notificationsTableView: UITableView!
    var presenter: SettingsPresenterProtocol?
    let  labelTableViewCell = "LabelTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStyle(.default)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        
        self.notificationsTableView.backgroundColor = UIColor.backgroundGrey
        self.notificationsTableView.registerCellFrom(labelTableViewCell)
        self.notificationsTableView.delegate = self
        self.notificationsTableView.dataSource = self
        self.navigationItem.title = "Notifications"
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
}
extension NotificationsViewController: SettingsViewProtocol {
    func onError(value: String) {
    }
    func showAlert(_ string: String) {
    }
}
extension NotificationsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Notifications.count.rawValue
    }
}
extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: labelTableViewCell) as? LabelTableViewCell else {
            return UITableViewCell()
        }
        guard let enumValue = Notifications.init(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch enumValue {
        case .shmoke: 
        cell.descLabel.text = "Shmoke"
        case .motch:
            cell.descLabel.text = "Motch"
        case .drop:
            cell.descLabel.text = "Drop"
        case .smo:
            cell.descLabel.text = "Smo"
        case .deals:
            cell.descLabel.text = "Deals"
        case .smoIous:
            cell.descLabel.text = "Smo IOU's"
        default:
            break
        }
        cell.hideToogleButton(value: false)
        return cell
    }
    
    
}
