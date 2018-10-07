//
//  HomeViewController.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 05/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//
enum HomeViewSections:Int {
    case shmokButton
    case shmokeCurrentSessions
    case matchButton
    case matchCurrentSessions
    case dropButton
    case dropCurrentSessions
    case smoButton
    case smoCurrentSessions
    case seshType
    case point
    case gram
    case reason
    case strain
    case date
    case time
    case location
    case utensils
    case addBuddies
    case buddiesList
    case count
}

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var bottomTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraintTableView: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var menuBarButton = UIBarButtonItem()
    var presenter: HomePresenterProtocol?
    var selectedSessionType: SessionType = .none
    var isShmokeSelected = false
    var isMatchSelected = false
    var isDropSelected = false
    var isSMOSelected = false
    var shmokeSessionHandler =  SHMOKSessionHandler()
    var matchSessionHandler = MatchSessionHandler()
    var dropSessionHandler = DropSessionHandler()
    var smoSessionHandler = SMOSssionHandler()
    
    let homeButtonTableViewCell = "HomeButtonTableViewCell"
    let sessionTypeTableViewCell = "SessionTypeTableViewCell"
    let currentSessionTableViewCell = "CurrentSessionTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializePresenter()
        self.setUPTableView()
        self.changeStyle(.default)
        self.showMenuBarButton(true)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavBarRightButton(type: .plus)
    }
    func setUPTableView() {
        self.homeTableView.registerCellFrom(homeButtonTableViewCell)
        self.homeTableView.registerCellFrom(sessionTypeTableViewCell)
        self.homeTableView.registerCellFrom(currentSessionTableViewCell)
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.reloadData()
        updateTableViewHeight()
    }
    func initializePresenter() {
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol & HomeDataManagerOutputProtocol = HomeInteractor()
        let wireFrame: HomeWireFrameProtocol = HomeWireFrame()
        self.presenter = presenter
        presenter.view = self
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
    }
    @IBAction override func menuBarBurronItemAction(_ sender: UIBarButtonItem) {
        self.frostedViewController.presentMenuViewController()
    }
    @objc func shmokeButtonClicked(_ sender: Any) {
        self.isMatchSelected = false
        self.isDropSelected = false
        self.isSMOSelected = false
        self.isShmokeSelected = !self.isShmokeSelected
        if !self.isShmokeSelected, self.selectedSessionType == .SHMOKE {
            self.selectedSessionType = .none
        } else {
            self.selectedSessionType = .SHMOKE
        }
        self.homeTableView.reloadData()
        updateTableViewHeight()
    }
    @objc func smoButtonClicked(_ sender: Any) {
        self.isMatchSelected = false
        self.isDropSelected = false
        self.isShmokeSelected = false
        self.isSMOSelected = !self.isSMOSelected
        if !self.isSMOSelected, self.selectedSessionType == .SMO {
            self.selectedSessionType = .none
        }else {
            self.selectedSessionType = .SMO
        }
         self.homeTableView.reloadData()
    }
    @objc func dropButtonClicked(_ sender: Any) {
        self.isMatchSelected = false
        self.isShmokeSelected = false
        self.isSMOSelected = false
        self.isDropSelected = !self.isDropSelected
        if !self.isDropSelected, self.selectedSessionType == .DROP {
            self.selectedSessionType = .none
        }else {
            self.selectedSessionType = .DROP
        }
         self.homeTableView.reloadData()
    }
    @objc func matchButtonClicked(_ sender: Any) {
        self.isShmokeSelected = false
        self.isDropSelected = false
        self.isSMOSelected = false
        self.isMatchSelected = !self.isMatchSelected
        if !self.isMatchSelected, self.selectedSessionType == .MATCH {
            self.selectedSessionType = .none
        }else {
            self.selectedSessionType = .MATCH
        }
         self.homeTableView.reloadData()
    }
    @objc func addBuddyButtonAction(_sender: UIButton) {
        switch selectedSessionType {
        case .SHMOKE:
            var currentBuddyList = shmokeSessionHandler.buddiesList
            currentBuddyList.append([:])
            shmokeSessionHandler.buddiesList = currentBuddyList
        case .MATCH:
            var currentBuddyList = matchSessionHandler.buddiesList
            currentBuddyList.append([:])
            matchSessionHandler.buddiesList = currentBuddyList
        case .DROP:
            var currentBuddyList = dropSessionHandler.buddiesList
            currentBuddyList.append([:])
            dropSessionHandler.buddiesList = currentBuddyList
        case .SMO:
            var currentBuddyList = smoSessionHandler.buddiesList
            currentBuddyList.append([:])
            smoSessionHandler.buddiesList = currentBuddyList
        default:
            break
        }
        self.homeTableView.reloadData()
    }
    @objc func removeBuddyButtonAction(_sender: UIButton) {
        switch selectedSessionType {
        case .SHMOKE:
            var currentBuddyList = shmokeSessionHandler.buddiesList
            currentBuddyList.remove(at: _sender.tag)
            shmokeSessionHandler.buddiesList = currentBuddyList
        case .MATCH:
            var currentBuddyList = matchSessionHandler.buddiesList
            currentBuddyList.remove(at: _sender.tag)
            matchSessionHandler.buddiesList = currentBuddyList
        case .DROP:
            var currentBuddyList = dropSessionHandler.buddiesList
            currentBuddyList.remove(at: _sender.tag)
            dropSessionHandler.buddiesList = currentBuddyList
        case .SMO:
            var currentBuddyList = smoSessionHandler.buddiesList
            currentBuddyList.remove(at: _sender.tag)
            smoSessionHandler.buddiesList = currentBuddyList
        default:
            break
        }
        self.homeTableView.reloadData()
    }
    
}
extension HomeViewController: HomeViewProtocol {
    func onError(value: String) {
    }
    func showAlert(_ string: String) {
    }
}
extension HomeViewController: UITableViewDelegate {
}
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeViewSections.count.rawValue
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let enumVal = HomeViewSections.init(rawValue: section) else {
            return 0
        }
        switch enumVal {
        case .shmokButton:
            return 1
        case .matchButton:
            return 1
        case .dropButton:
            return 1
        case .smoButton:
            return 1
        case .seshType:
            if self.selectedSessionType == .none {
                return 0
            }
            return 1
        case .gram:
            if self.selectedSessionType == .MATCH {
                return 1
            }
        case .reason:
            if self.selectedSessionType == .SMO {
                return 1
            }
            return 0
        case .date:
            if self.selectedSessionType == .SMO {
                return 1
            }
            return 0
        case .strain:
            if self.selectedSessionType == .SHMOKE || self.selectedSessionType == .DROP || self.selectedSessionType == .MATCH {
                return 1
            }
            return 0
        case .time:
            if self.selectedSessionType == .SHMOKE || self.selectedSessionType == .DROP || self.selectedSessionType == .MATCH || self.selectedSessionType == .SMO{
                return 1
            }
            return 0
        case .location:
            if self.selectedSessionType == .none {
                return 0
            }
            return 1
        case .utensils:
            if self.selectedSessionType == .SMO || self.selectedSessionType == .none {
                return 0
            }
            return 1
        case .addBuddies:
            if self.selectedSessionType == .none {
                return 0
            }
            return 1
        case .buddiesList:
            if self.selectedSessionType == .none {
                return 0
            } else if selectedSessionType == .SHMOKE {
                return shmokeSessionHandler.buddiesList.count
            } else if selectedSessionType == .MATCH {
                return matchSessionHandler.buddiesList.count
            } else if selectedSessionType == .DROP {
                return dropSessionHandler.buddiesList.count
            } else if selectedSessionType == .SMO {
                return smoSessionHandler.buddiesList.count
            }
        case .point:
            if self.selectedSessionType == .DROP {
                return 1
            }
            return 0
        case .count:
            return 0
        case .shmokeCurrentSessions:
            return shmokeSessionHandler.currentSessions.count
        case .matchCurrentSessions:
            return matchSessionHandler.currentSessions.count
        case .dropCurrentSessions:
            return dropSessionHandler.currentSessions.count
        case .smoCurrentSessions:
            return smoSessionHandler.currentSessions.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let enumVal = HomeViewSections.init(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        guard let buttonCell = tableView.dequeueReusableCell(withIdentifier: homeButtonTableViewCell) as? HomeButtonTableViewCell else {
            return UITableViewCell()
        }
        guard let sessionTypeCell = tableView.dequeueReusableCell(withIdentifier: sessionTypeTableViewCell) as? SessionTypeTableViewCell else {
            return UITableViewCell()
        }
        guard let currentSessionCell = tableView.dequeueReusableCell(withIdentifier: currentSessionTableViewCell) as? CurrentSessionTableViewCell else {
            return UITableViewCell()
        }
        
        sessionTypeCell.setHeader(type: enumVal)
        sessionTypeCell.addOrRemoveButton.tag = indexPath.row
        switch enumVal {
        case .shmokButton:
            buttonCell.setUPUI(isButtonSelected: self.isShmokeSelected, type: .SHMOKE)
            buttonCell.button.addTarget(self, action: #selector(self.shmokeButtonClicked(_:)), for: .touchUpInside)
            updateTableViewHeight()
            return buttonCell
        case .shmokeCurrentSessions:
            return currentSessionCell
        case .dropButton:
             buttonCell.setUPUI(isButtonSelected: self.isDropSelected, type: .DROP)
             buttonCell.button.addTarget(self, action: #selector(self.dropButtonClicked(_:)), for: .touchUpInside)
              updateTableViewHeight()
            return buttonCell
        case .dropCurrentSessions:
            return currentSessionCell
        case .matchButton:
            buttonCell.setUPUI(isButtonSelected: self.isMatchSelected, type: .MATCH)
            buttonCell.button.addTarget(self, action: #selector(self.matchButtonClicked(_:)), for: .touchUpInside)
             updateTableViewHeight()
            return buttonCell
        case .matchCurrentSessions:
            return currentSessionCell
        case .smoButton:
            buttonCell.setUPUI(isButtonSelected: self.isSMOSelected, type: .SMO)
            buttonCell.button.addTarget(self, action: #selector(self.smoButtonClicked(_:)), for: .touchUpInside)
             updateTableViewHeight()
            return buttonCell
        case .smoCurrentSessions:
            return currentSessionCell
        case .seshType:
             updateTableViewHeight()
            return sessionTypeCell
        case .point:
             updateTableViewHeight()
            return sessionTypeCell
        case .gram:
             updateTableViewHeight()
            return sessionTypeCell
        case .reason:
             updateTableViewHeight()
            return sessionTypeCell
        case .strain:
             updateTableViewHeight()
            return sessionTypeCell
        case .time:
             updateTableViewHeight()
            return sessionTypeCell
        case .date:
            updateTableViewHeight()
            return sessionTypeCell
        case .location:
             updateTableViewHeight()
            return sessionTypeCell
        case .utensils:
             updateTableViewHeight()
            return sessionTypeCell
        case .addBuddies:
             updateTableViewHeight()
             sessionTypeCell.addOrRemoveButton.removeTarget(self, action: #selector(self.removeBuddyButtonAction(_sender:)), for: .touchUpInside)
             sessionTypeCell.addOrRemoveButton.addTarget(self, action: #selector(self.addBuddyButtonAction(_sender:)), for: .touchUpInside)
             return sessionTypeCell
        case .buddiesList:
            updateTableViewHeight()
            sessionTypeCell.addOrRemoveButton.removeTarget(self, action: #selector(self.addBuddyButtonAction(_sender:)), for: .touchUpInside)
            sessionTypeCell.addOrRemoveButton.addTarget(self, action: #selector(self.removeBuddyButtonAction(_sender:)), for: .touchUpInside)
            return sessionTypeCell
        default:
             return UITableViewCell()
        }
    }
    func updateTableViewHeight(){
        let contentHeight = homeTableView.contentSize.height
        if contentHeight >= screenHeight {
            self.bottomTableViewConstraint.constant = 0
            self.topConstraintTableView.constant = 0
            self.tableViewHeightConstraint.constant = screenHeight
        } else {
            let margin = ((screenHeight - self.getNavigationBarHeight()) - contentHeight)/2
            self.bottomTableViewConstraint.constant = margin
            self.topConstraintTableView.constant = margin
            self.tableViewHeightConstraint.constant = contentHeight
        }
    }
}
