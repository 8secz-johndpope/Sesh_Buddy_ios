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
    var notificationSettings: NotificationSetting!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStyle(.default)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        
        self.notificationsTableView.backgroundColor = UIColor.backgroundGrey
        self.notificationsTableView.registerCellFrom(labelTableViewCell)
        self.notificationsTableView.delegate = self
        self.notificationsTableView.dataSource = self
        self.navigationItem.title = "Notifications"
        self.presenter?.getNotificationSetting()
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
    @objc func notificationToggleChange(_ sender: UISwitch) {
        guard let enumValu = Notifications.init(rawValue: sender.tag) else {
            return
        }
        switch enumValu {
        case .shmoke:
            self.presenter?.isSHMOKeEnabled = !self.presenter!.isSHMOKeEnabled!
        case .motch:
             self.presenter?.isMATCHEnabled = !self.presenter!.isMATCHEnabled!
        case .smo:
             self.presenter?.isSMOEnabled = !self.presenter!.isSMOEnabled!
        case .smoIous:
             self.presenter?.isSMOIOUEnabled = !self.presenter!.isSMOIOUEnabled!
        case .drop:
             self.presenter?.isDROPEnabled = !self.presenter!.isDROPEnabled!
        case .deals:
             self.presenter?.isDEALSEnabled = !self.presenter!.isDEALSEnabled!
        default:
            break
        }
        self.presenter?.updateNotificationSettings()
    }
}
extension NotificationsViewController: SettingsViewProtocol {
    func reloadView(_ with: NotificationSetting) {
        self.notificationSettings = with
        self.presenter?.isSHMOKeEnabled = with.data.seshShmoke
        self.presenter?.isMATCHEnabled = with.data.seshMatch
        self.presenter?.isDEALSEnabled = with.data.seshDeals
        self.presenter?.isSMOEnabled = with.data.seshSmo
        self.presenter?.isSMOIOUEnabled = with.data.seshSmoIou
        self.presenter?.isDROPEnabled = with.data.seshDrop
        self.notificationsTableView.reloadData()
    }
    func onError(value: String) {
        if self.notificationSettings != nil {
            let with = self.notificationSettings!
            self.presenter?.isSHMOKeEnabled = with.data.seshShmoke
            self.presenter?.isMATCHEnabled = with.data.seshMatch
            self.presenter?.isDEALSEnabled = with.data.seshDeals
            self.presenter?.isSMOEnabled = with.data.seshSmo
            self.presenter?.isSMOIOUEnabled = with.data.seshSmoIou
            self.presenter?.isDROPEnabled = with.data.seshDrop
            self.notificationsTableView.reloadData()
        }
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
            cell.descLabel.text = "Match"
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
        cell.setUPToggle(with: self.notificationSettings, type: enumValue)
        cell.hideToogleButton(value: false)
        cell.toggleSwitch.tag = indexPath.section
        cell.toggleSwitch.addTarget(self, action: #selector(notificationToggleChange(_:)), for: .valueChanged)
        return cell
    }
    
    
}
