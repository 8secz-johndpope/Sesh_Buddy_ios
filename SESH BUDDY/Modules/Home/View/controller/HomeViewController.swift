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
    case buddiesList
    case buddyUpButton
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
    
    let addBuddyBaseTag = 60000
    let kLocationTag = 5000
    var sessionStatusPopUPVC : SeshStatusViewController!
    var sessionDetailsPopUPVc: SessionDetailViewController!
    var transparentView: UIView!
    
    let homeButtonTableViewCell = "HomeButtonTableViewCell"
    let sessionTypeTableViewCell = "SessionTypeTableViewCell"
    let currentSessionTableViewCell = "CurrentSessionTableViewCell"
    
    let shmokeIdentifier = "SHMOKEHomeButtonTableViewCell"
    let matchIdentifier = "MATCHHomeButtonTableViewCell"
    let dropIdentifier = "DROPHomeButtonTableViewCell"
    let smoIdentifier = "SMOHomeButtonTableViewCell"
    
    var sessionsData = Common.share.getSessionsArray()
    
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
        presentAcceptSessionPopUP(sessionDetailType: .acceptSession, session: sessionsData[0])
    }
    func setUPTableView() {
        let firstSesh = Common.share.getSeshTypeList().first!
        let strain = Common.share.getStrainTypeList().first!
        let utensil = Common.share.getUtensilTypeList().first!
        let gram = Common.share.getGramTypeList().first!
        let points = Common.share.getPointsTypeList().first!
        let reason = Common.share.getReasonsTypeList().first!
        
        
        shmokeSessionHandler.selectedSeshType = firstSesh
        shmokeSessionHandler.selectedStrainType = strain
        shmokeSessionHandler.selectedUtensilType = utensil
        
        matchSessionHandler.selectedStrainType = strain
        matchSessionHandler.selectedSeshType = firstSesh
        matchSessionHandler.selectedUtensilType = utensil
        matchSessionHandler.selectedGramType = gram
        
        
        dropSessionHandler.selectedStrainType = strain
        dropSessionHandler.selectedUtensilType = utensil
        dropSessionHandler.selectedPointType = points
        dropSessionHandler.selectedSeshType = firstSesh
        
        
        smoSessionHandler.selectedSeshType = firstSesh
        smoSessionHandler.selectedReasonsType = reason
        
        
        
        
        self.homeTableView.registerCellFrom(homeButtonTableViewCell)
        self.homeTableView.registerCellFrom(homeButtonTableViewCell, identifier: shmokeIdentifier)
        self.homeTableView.registerCellFrom(homeButtonTableViewCell, identifier: matchIdentifier)
        self.homeTableView.registerCellFrom(homeButtonTableViewCell, identifier: dropIdentifier)
        self.homeTableView.registerCellFrom(homeButtonTableViewCell, identifier: smoIdentifier)
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
    @objc func buddyUpButtonClicked(_ sender: Any) {
        switch self.selectedSessionType {
        case .SHMOKE:
           let sessionToBeAdded =  self.presenter?.buddyUpWith(shmokeHandler: shmokeSessionHandler)
           if sessionToBeAdded != nil {
            self.openSeshUPSession(sessionType: .addSession, session: sessionToBeAdded!)
            }
            
        case .DROP:
           let sessionToBeAdded = self.presenter?.buddyUpWith(dropHandler: dropSessionHandler)
            if sessionToBeAdded != nil {
                self.openSeshUPSession(sessionType: .addSession, session: sessionToBeAdded!)
            }
        case .MATCH:
           let sessionToBeAdded = self.presenter?.buddyUpWith(matchHandler: matchSessionHandler)
            if sessionToBeAdded != nil {
                self.openSeshUPSession(sessionType: .addSession, session: sessionToBeAdded!)
}
        case .SMO:
           let sessionToBeAdded = self.presenter?.buddyUpWith(smoHandler: smoSessionHandler)
            if sessionToBeAdded != nil {
                self.openSeshUPSession(sessionType: .addSession, session: sessionToBeAdded!)
            }
        default:
            break
        }
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
            currentBuddyList.append("")
            shmokeSessionHandler.buddiesList = currentBuddyList
        case .MATCH:
            var currentBuddyList = matchSessionHandler.buddiesList
            currentBuddyList.append("")
            matchSessionHandler.buddiesList = currentBuddyList
        case .DROP:
            var currentBuddyList = dropSessionHandler.buddiesList
            currentBuddyList.append("")
            dropSessionHandler.buddiesList = currentBuddyList
        case .SMO:
            var currentBuddyList = smoSessionHandler.buddiesList
            currentBuddyList.append("")
            smoSessionHandler.buddiesList = currentBuddyList
        default:
            break
        }
        self.homeTableView.reloadData()
    }
    
    func addBuddy(with: String, at: Int) {
        switch selectedSessionType {
        case .SHMOKE:
            var currentBuddyList = shmokeSessionHandler.buddiesList
            currentBuddyList[at] = with
            shmokeSessionHandler.buddiesList = currentBuddyList
        case .MATCH:
            var currentBuddyList = matchSessionHandler.buddiesList
            currentBuddyList[at] = with
            matchSessionHandler.buddiesList = currentBuddyList
        case .DROP:
            var currentBuddyList = dropSessionHandler.buddiesList
            currentBuddyList[at] = with
            dropSessionHandler.buddiesList = currentBuddyList
        case .SMO:
            var currentBuddyList = smoSessionHandler.buddiesList
            currentBuddyList[at] = with
            smoSessionHandler.buddiesList = currentBuddyList
        default:
            break
        }
        self.homeTableView.reloadData()
    }
    func addLocation(with: String) {
        switch selectedSessionType {
        case .SHMOKE:
            shmokeSessionHandler.selectedLocation = with
        case .MATCH:
            matchSessionHandler.selectedLocation = with
        case .DROP:
            dropSessionHandler.selectedLocation = with
        case .SMO:
            smoSessionHandler.selectedLocation = with
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
        DispatchQueue.main.async {
            UIAlertController.presentAlert(title: nil, message: string, style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
        }
        
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
            if self.selectedSessionType == .none {
                return 0
            }
            return 1
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
        
        case .buddiesList:
            if self.selectedSessionType == .none {
                return 0
            } else if selectedSessionType == .SHMOKE {
                if shmokeSessionHandler.buddiesList.count == 0 {
                    return 1
                }
                return shmokeSessionHandler.buddiesList.count
            } else if selectedSessionType == .MATCH {
                if matchSessionHandler.buddiesList.count == 0 {
                    return 1
                }
                return matchSessionHandler.buddiesList.count
            } else if selectedSessionType == .DROP {
                if dropSessionHandler.buddiesList.count == 0 {
                    return 1
                }
                return dropSessionHandler.buddiesList.count
            } else if selectedSessionType == .SMO {
                if smoSessionHandler.buddiesList.count == 0 {
                    return 1
                }
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
        case .buddyUpButton:
            if self.selectedSessionType == .none {
                return 0
            }
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let enumVal = HomeViewSections.init(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        guard let buddyUPButtonCell = tableView.dequeueReusableCell(withIdentifier: homeButtonTableViewCell) as? HomeButtonTableViewCell else {
            return UITableViewCell()
        }
        guard let shmokeButtonCell = tableView.dequeueReusableCell(withIdentifier: shmokeIdentifier) as? HomeButtonTableViewCell else {
            return UITableViewCell()
        }
        guard let matchButtonCell = tableView.dequeueReusableCell(withIdentifier: matchIdentifier) as? HomeButtonTableViewCell else {
            return UITableViewCell()
        }
        guard let dropButtonCell = tableView.dequeueReusableCell(withIdentifier: dropIdentifier) as? HomeButtonTableViewCell else {
            return UITableViewCell()
        }
        guard let smoButtonCell = tableView.dequeueReusableCell(withIdentifier: smoIdentifier) as? HomeButtonTableViewCell else {
            return UITableViewCell()
        }
        
        guard let sessionTypeCell = tableView.dequeueReusableCell(withIdentifier: sessionTypeTableViewCell) as? SessionTypeTableViewCell else {
            return UITableViewCell()
        }
        guard let currentSessionCell = tableView.dequeueReusableCell(withIdentifier: currentSessionTableViewCell) as? CurrentSessionTableViewCell else {
            return UITableViewCell()
        }
        self.setUPSessionTypeCell(at: indexPath.section, cell: sessionTypeCell)
        
        sessionTypeCell.setHeader(type: enumVal)
        sessionTypeCell.addOrRemoveButton.tag = indexPath.row
        switch enumVal {
        case .shmokButton:
            shmokeButtonCell.setUPUI(isButtonSelected: self.isShmokeSelected, type: .shmokButton)
            self.removeAllTargetFrom(button: shmokeButtonCell.button)
            shmokeButtonCell.button.addTarget(self, action: #selector(self.shmokeButtonClicked(_:)), for: .touchUpInside)
            updateTableViewHeight()
            return shmokeButtonCell
        case .shmokeCurrentSessions:
            let sessionName = self.shmokeSessionHandler.currentSessions[indexPath.row]
            currentSessionCell.setSessionDetails(type: .SHMOKE, text: sessionName)
            return currentSessionCell
        case .dropButton:
             dropButtonCell.setUPUI(isButtonSelected: self.isDropSelected, type: .dropButton)
             self.removeAllTargetFrom(button: dropButtonCell.button)
             dropButtonCell.button.addTarget(self, action: #selector(self.dropButtonClicked(_:)), for: .touchUpInside)
              updateTableViewHeight()
            return dropButtonCell
        case .dropCurrentSessions:
            let sessionName = self.dropSessionHandler.currentSessions[indexPath.row]
            currentSessionCell.setSessionDetails(type: .DROP, text: sessionName)
            return currentSessionCell
        case .matchButton:
            matchButtonCell.setUPUI(isButtonSelected: self.isMatchSelected, type: .matchButton)
            self.removeAllTargetFrom(button: matchButtonCell.button)
            matchButtonCell.button.addTarget(self, action: #selector(self.matchButtonClicked(_:)), for: .touchUpInside)
             updateTableViewHeight()
            return matchButtonCell
        case .matchCurrentSessions:
            let sessionName = self.matchSessionHandler.currentSessions[indexPath.row]
            currentSessionCell.setSessionDetails(type: .MATCH, text: sessionName)
            return currentSessionCell
        case .smoButton:
            smoButtonCell.setUPUI(isButtonSelected: self.isSMOSelected, type: .smoButton)
            self.removeAllTargetFrom(button: smoButtonCell.button)
            smoButtonCell.button.addTarget(self, action: #selector(self.smoButtonClicked(_:)), for: .touchUpInside)
             updateTableViewHeight()
            return smoButtonCell
        case .smoCurrentSessions:
            let sessionName = self.smoSessionHandler.currentSessions[indexPath.row]
            currentSessionCell.setSessionDetails(type: .SMO, text: sessionName)
            return currentSessionCell
        case .seshType:
             updateTableViewHeight()
             sessionTypeCell.sessionTextField.tag = indexPath.section
             self.setPickerToTextfieldInputAccessoryView(textfield: sessionTypeCell.sessionTextField)
            return sessionTypeCell
        case .point:
             updateTableViewHeight()
             sessionTypeCell.sessionTextField.tag = indexPath.section
             self.setPickerToTextfieldInputAccessoryView(textfield: sessionTypeCell.sessionTextField)
            return sessionTypeCell
        case .gram:
             updateTableViewHeight()
             sessionTypeCell.sessionTextField.tag = indexPath.section
             self.setPickerToTextfieldInputAccessoryView(textfield: sessionTypeCell.sessionTextField)
            return sessionTypeCell
        case .reason:
             updateTableViewHeight()
             sessionTypeCell.sessionTextField.tag = indexPath.section
             self.setPickerToTextfieldInputAccessoryView(textfield: sessionTypeCell.sessionTextField)
            return sessionTypeCell
        case .strain:
             updateTableViewHeight()
             sessionTypeCell.sessionTextField.tag = indexPath.section
             self.setPickerToTextfieldInputAccessoryView(textfield: sessionTypeCell.sessionTextField)
            return sessionTypeCell
        case .time:
             updateTableViewHeight()
             sessionTypeCell.sessionTextField.tag = indexPath.section
             self.setDatePickerToTextFieldInputAccessoryView(textfield: sessionTypeCell.sessionTextField, mode: .time)
            return sessionTypeCell
        case .date:
            updateTableViewHeight()
            sessionTypeCell.sessionTextField.tag = indexPath.section
            self.setDatePickerToTextFieldInputAccessoryView(textfield: sessionTypeCell.sessionTextField, mode: .date)
            return sessionTypeCell
        case .location:
             updateTableViewHeight()
             sessionTypeCell.sessionTextField.tag = kLocationTag
             sessionTypeCell.sessionTextField.inputAccessoryView = nil
             sessionTypeCell.sessionTextField.inputView = nil
            return sessionTypeCell
        case .utensils:
             updateTableViewHeight()
             sessionTypeCell.sessionTextField.tag = indexPath.section
             self.setPickerToTextfieldInputAccessoryView(textfield: sessionTypeCell.sessionTextField)
            return sessionTypeCell
//        case .addBuddies:
//             updateTableViewHeight()
//             sessionTypeCell.sessionTextField.inputAccessoryView = nil
//             sessionTypeCell.sessionTextField.inputView = nil
//             sessionTypeCell.sessionTextField.tag = addBuddyBaseTag + indexPath.row
//             sessionTypeCell.addOrRemoveButton.removeTarget(self, action: #selector(self.removeBuddyButtonAction(_sender:)), for: .touchUpInside)
//             sessionTypeCell.sessionTextField.text = ""
//             sessionTypeCell.addOrRemoveButton.addTarget(self, action: #selector(self.addBuddyButtonAction(_sender:)), for: .touchUpInside)
//             return sessionTypeCell
        case .buddiesList:
            self.setBuddyData(at:  indexPath.row, cell: sessionTypeCell)
            sessionTypeCell.sessionTextField.tag =  addBuddyBaseTag + indexPath.row
            sessionTypeCell.sessionTextField.inputAccessoryView = nil
            sessionTypeCell.sessionTextField.inputView = nil
            updateTableViewHeight()
            if indexPath.row == 0 {
                sessionTypeCell.addOrRemoveButton.removeTarget(self, action: #selector(self.removeBuddyButtonAction(_sender:)), for: .touchUpInside)
                 sessionTypeCell.addOrRemoveButton.addTarget(self, action: #selector(self.addBuddyButtonAction(_sender:)), for: .touchUpInside)
                sessionTypeCell.addOrRemoveButton.setImage(Icons.plusRound, for: .normal)
            } else {
                
                sessionTypeCell.addOrRemoveButton.removeTarget(self, action: #selector(self.addBuddyButtonAction(_sender:)), for: .touchUpInside)
                sessionTypeCell.addOrRemoveButton.addTarget(self, action: #selector(self.removeBuddyButtonAction(_sender:)), for: .touchUpInside)
                
                sessionTypeCell.addOrRemoveButton.setImage(Icons.delete, for: .normal)
            }
            
            
            
            return sessionTypeCell
        case .buddyUpButton:
            updateTableViewHeight()
            buddyUPButtonCell.setUPUI(isButtonSelected: true, type: .buddyUpButton)
            self.removeAllTargetFrom(button: buddyUPButtonCell.button)
            buddyUPButtonCell.button.addTarget(self, action: #selector(self.buddyUpButtonClicked(_:)), for: .touchUpInside)
            updateTableViewHeight()
            return buddyUPButtonCell
        default:
             return UITableViewCell()
        }
    }
    func updateTableViewHeight(){
        let contentHeight = homeTableView.contentSize.height
        let totalHeight = screenHeight - (1 * CGFloat(navigationBarHeight))
        if contentHeight >= totalHeight {
            self.bottomTableViewConstraint.constant = 0
            self.topConstraintTableView.constant = CGFloat(navigationBarHeight)
            self.tableViewHeightConstraint.constant = totalHeight
        } else {
            let margin = ((screenHeight) - contentHeight)/2
            self.bottomTableViewConstraint.constant = margin
            self.topConstraintTableView.constant = margin
            self.tableViewHeightConstraint.constant = contentHeight
        }
    }
    func removeAllTargetFrom(button: UIButton) {
        button.removeTarget(nil, action: #selector(self.matchButtonClicked(_:)), for: .touchUpInside)
        button.removeTarget(nil, action: #selector(self.shmokeButtonClicked(_:)), for: .touchUpInside)
        button.removeTarget(nil, action: #selector(self.smoButtonClicked(_:)), for: .touchUpInside)
        button.removeTarget(nil, action: #selector(self.dropButtonClicked(_:)), for: .touchUpInside)
    }
    func setBuddyData(at:  Int, cell: SessionTypeTableViewCell) {
        cell.sessionTextField.delegate = self
        if at == 0 {
            cell.headeLabelBottomConstraint.constant = 20
            cell.headerTileLabel.text = AppStrings.buddies.localized
            cell.headerTileLabel.isHidden = false
        } else {
            cell.headeLabelBottomConstraint.constant = 0
            cell.headerTileLabel.text = ""
            cell.headerTileLabel.isHidden = true
        }
        if isShmokeSelected == true {
            if at <  self.shmokeSessionHandler.buddiesList.count, !self.shmokeSessionHandler.buddiesList[at].isEmpty {
                cell.sessionTextField.text =  self.shmokeSessionHandler.buddiesList[at]
            } else {
                cell.sessionTextField.text =  ""
            }
            
        } else if isMatchSelected == true {
            if at <  self.matchSessionHandler.buddiesList.count, !self.matchSessionHandler.buddiesList[at].isEmpty {
                cell.sessionTextField.text =  self.matchSessionHandler.buddiesList[at]
            } else {
                cell.sessionTextField.text =  ""
            }
        } else if isDropSelected == true {
            if at <  self.dropSessionHandler.buddiesList.count, !self.dropSessionHandler.buddiesList[at].isEmpty {
                cell.sessionTextField.text =  self.dropSessionHandler.buddiesList[at]
            } else {
                cell.sessionTextField.text =  ""
            }
        } else if isSMOSelected == true {
            if at <  self.smoSessionHandler.buddiesList.count, !self.smoSessionHandler.buddiesList[at].isEmpty {
                cell.sessionTextField.text =  self.smoSessionHandler.buddiesList[at]
            } else {
                cell.sessionTextField.text =  ""
            }
        }
    }
    func setUPSessionTypeCell(at: Int, cell: SessionTypeTableViewCell) {
        guard let enumVal = HomeViewSections.init(rawValue: at) else {
            return
        }
        switch enumVal {
        case .seshType:
            if isShmokeSelected == true {
               cell.sessionTextField.text =  self.shmokeSessionHandler.selectedSeshType
            } else if isMatchSelected == true {
               cell.sessionTextField.text = self.matchSessionHandler.selectedSeshType
            } else if isDropSelected == true {
               cell.sessionTextField.text = self.dropSessionHandler.selectedSeshType
            } else if isSMOSelected == true {
              cell.sessionTextField.text =  self.smoSessionHandler.selectedSeshType
            }
        case .strain:
            if isShmokeSelected == true {
                cell.sessionTextField.text = self.shmokeSessionHandler.selectedStrainType
            } else if isMatchSelected == true {
               cell.sessionTextField.text = self.matchSessionHandler.selectedStrainType
            } else if isDropSelected == true {
              cell.sessionTextField.text =  self.dropSessionHandler.selectedStrainType
            }
        case .point:
            if isDropSelected == true {
               cell.sessionTextField.text = self.dropSessionHandler.selectedPointType
            }
        case .utensils:
            if isShmokeSelected == true {
                cell.sessionTextField.text = self.shmokeSessionHandler.selectedUtensilType
            } else if isMatchSelected == true {
                cell.sessionTextField.text = self.matchSessionHandler.selectedUtensilType
            } else if isDropSelected == true {
                cell.sessionTextField.text = self.dropSessionHandler.selectedUtensilType
            }
        case .reason:
            if isSMOSelected == true {
                cell.sessionTextField.text = self.smoSessionHandler.selectedReasonsType
            }
        case .date:
            if isShmokeSelected == true {
                cell.sessionTextField.text =  self.shmokeSessionHandler.selectedDate
            } else if isMatchSelected == true {
                cell.sessionTextField.text = self.matchSessionHandler.selectedDate
            } else if isDropSelected == true {
                cell.sessionTextField.text = self.dropSessionHandler.selectedDate
            } else if isSMOSelected == true {
                cell.sessionTextField.text =  self.smoSessionHandler.selectedDate
            }
        case .time:
            if isShmokeSelected == true {
                cell.sessionTextField.text =  self.shmokeSessionHandler.selectedTime
            } else if isMatchSelected == true {
                cell.sessionTextField.text = self.matchSessionHandler.selectedTime
            } else if isDropSelected == true {
                cell.sessionTextField.text = self.dropSessionHandler.selectedTime
            } else if isSMOSelected == true {
                cell.sessionTextField.text =  self.smoSessionHandler.selectedTime
            }
        case .location:
            cell.sessionTextField.delegate = self
            if isShmokeSelected == true {
                cell.sessionTextField.text =  self.shmokeSessionHandler.selectedLocation
            } else if isMatchSelected == true {
                cell.sessionTextField.text = self.matchSessionHandler.selectedLocation
            } else if isDropSelected == true {
                cell.sessionTextField.text = self.dropSessionHandler.selectedLocation
            } else if isSMOSelected == true {
                cell.sessionTextField.text =  self.smoSessionHandler.selectedLocation
            }
        case .gram:
            if isMatchSelected == true {
                cell.sessionTextField.text =  self.matchSessionHandler.selectedGramType
            }
        default:
            break
        }
        return
    }
    func setPickerToTextfieldInputAccessoryView(textfield: UITextField) {
        let genderPicker = UIPickerView()
        genderPicker.tag = textfield.tag
        genderPicker.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 216.0)
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderPicker.backgroundColor = UIColor.backgroundGrey
        textfield.inputAccessoryView = genderPicker
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneButtonAction(sender:)))
        doneButton.tag = textfield.tag
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: screenHeight , width: screenWidth, height: 44.0))
        toolBar.barStyle = .default
        toolBar.items = [flexibleSpace, doneButton]
        textfield.inputAccessoryView = toolBar
        textfield.inputView = genderPicker
    }
    @objc func doneButtonAction(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        
        let dateFormatter = DateFormatter()
        guard let enumVal = HomeViewSections.init(rawValue: sender.tag) else {
            return
        }
        switch enumVal {
        case .date:
            var selectedDate = ""
            dateFormatter.dateFormat = "MMMM dd, yyyy"//"MMMM dd yyyy"
            // let orderDateString = dateFormatter.string(from: datePicker.date)
            
            if isShmokeSelected == true {
                selectedDate = self.shmokeSessionHandler.selectedDate
            } else if isMatchSelected == true {
                selectedDate = self.matchSessionHandler.selectedDate
            } else if isDropSelected == true {
                selectedDate = self.dropSessionHandler.selectedDate
            } else if isSMOSelected == true {
                selectedDate = self.smoSessionHandler.selectedDate
            }
            
            if selectedDate.isEmpty {
                let orderDateString  = dateFormatter.string(from: Date())
                if isShmokeSelected == true {
                     self.shmokeSessionHandler.selectedDate = orderDateString
                } else if isMatchSelected == true {
                     self.matchSessionHandler.selectedDate = orderDateString
                } else if isDropSelected == true {
                     self.dropSessionHandler.selectedDate = orderDateString
                } else if isSMOSelected == true {
                     self.smoSessionHandler.selectedDate = orderDateString
                }
            }
            
        case .time:
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.timeStyle = .long//"MMMM dd yyyy"
            var selectedTime = ""
            if isShmokeSelected == true {
                selectedTime = self.shmokeSessionHandler.selectedTime
            } else if isMatchSelected == true {
                selectedTime = self.matchSessionHandler.selectedTime
            } else if isDropSelected == true {
                selectedTime = self.dropSessionHandler.selectedTime
            } else if isSMOSelected == true {
                selectedTime = self.smoSessionHandler.selectedTime
            }
            
            if selectedTime.isEmpty {
                let orderDateString  = dateFormatter.string(from: Date())
                if isShmokeSelected == true {
                    self.shmokeSessionHandler.selectedTime = orderDateString
                } else if isMatchSelected == true {
                    self.matchSessionHandler.selectedTime = orderDateString
                } else if isDropSelected == true {
                    self.dropSessionHandler.selectedTime = orderDateString
                } else if isSMOSelected == true {
                    self.smoSessionHandler.selectedTime = orderDateString
                }
            }
        case .seshType:
            
            var selectedSess = ""
            if isShmokeSelected == true {
                selectedSess = self.shmokeSessionHandler.selectedSeshType
            } else if isMatchSelected == true {
                selectedSess = self.matchSessionHandler.selectedSeshType
            } else if isDropSelected == true {
                selectedSess = self.dropSessionHandler.selectedSeshType
            } else if isSMOSelected == true {
                selectedSess = self.smoSessionHandler.selectedSeshType
            }
            
            if selectedSess.isEmpty, !Common.share.getSeshTypeList().first!.isEmpty {
                let orderDateString  = Common.share.getSeshTypeList().first!
                if isShmokeSelected == true {
                    self.shmokeSessionHandler.selectedSeshType = orderDateString
                } else if isMatchSelected == true {
                    self.matchSessionHandler.selectedSeshType = orderDateString
                } else if isDropSelected == true {
                    self.dropSessionHandler.selectedSeshType = orderDateString
                } else if isSMOSelected == true {
                    self.smoSessionHandler.selectedSeshType = orderDateString
                }
            }
        case .strain:
            var selectedSess = ""
            if isShmokeSelected == true {
                selectedSess = self.shmokeSessionHandler.selectedStrainType
            } else if isMatchSelected == true {
                selectedSess = self.matchSessionHandler.selectedStrainType
            } else if isDropSelected == true {
                selectedSess = self.dropSessionHandler.selectedStrainType
            }
            
            if selectedSess.isEmpty, !Common.share.getStrainTypeList().first!.isEmpty {
                let orderDateString  = Common.share.getStrainTypeList().first!
                if isShmokeSelected == true {
                    self.shmokeSessionHandler.selectedStrainType = orderDateString
                } else if isMatchSelected == true {
                    self.matchSessionHandler.selectedStrainType = orderDateString
                } else if isDropSelected == true {
                    self.dropSessionHandler.selectedStrainType = orderDateString
                }
            }
        case .gram:
            var selectedSess = ""
            if isMatchSelected == true {
                selectedSess = self.matchSessionHandler.selectedGramType
            }
            
            if selectedSess.isEmpty, !Common.share.getGramTypeList().first!.isEmpty {
                let orderDateString  = Common.share.getGramTypeList().first!
                 if isMatchSelected == true {
                    self.matchSessionHandler.selectedGramType = orderDateString
                }
            }
        case .utensils:
            var selectedSess = ""
            if isShmokeSelected == true {
                selectedSess = self.shmokeSessionHandler.selectedUtensilType
            } else if isMatchSelected == true {
                selectedSess = self.matchSessionHandler.selectedUtensilType
            } else if isDropSelected == true {
                selectedSess = self.dropSessionHandler.selectedUtensilType
            }
            
            if selectedSess.isEmpty, !Common.share.getUtensilTypeList().first!.isEmpty {
                let orderDateString  = Common.share.getUtensilTypeList().first!
                if isShmokeSelected == true {
                    self.shmokeSessionHandler.selectedUtensilType = orderDateString
                } else if isMatchSelected == true {
                    self.matchSessionHandler.selectedUtensilType = orderDateString
                } else if isDropSelected == true {
                    self.dropSessionHandler.selectedUtensilType = orderDateString
                }
            }
        case .point:
            var selectedSess = ""
              if isDropSelected == true {
                selectedSess = self.dropSessionHandler.selectedPointType
            }
            if selectedSess.isEmpty, !Common.share.getPointsTypeList().first!.isEmpty {
                let orderDateString  = Common.share.getPointsTypeList().first!
                 if isDropSelected == true {
                    self.dropSessionHandler.selectedPointType = orderDateString
                }
            }
        case .reason:
            var selectedSess = ""
             if isSMOSelected == true {
                selectedSess = self.smoSessionHandler.selectedReasonsType
            }
            
            if selectedSess.isEmpty, !Common.share.getReasonsTypeList().first!.isEmpty {
                let orderDateString  = Common.share.getReasonsTypeList().first!
                 if isSMOSelected == true {
                    self.smoSessionHandler.selectedReasonsType = orderDateString
                }
            }
        default:
            break
        }
        self.homeTableView.reloadData()
    }
    func getMinimumDateToBeSelect(forType: Int) -> Date {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        guard let enumVal = HomeViewSections.init(rawValue: forType) else {
            return currentDate
        }
        var selectedDate = ""
        
        switch enumVal {
        case .date:
            dateFormatter.dateFormat = "MMMM dd, yyyy"//"MMMM dd yyyy"
           // let orderDateString = dateFormatter.string(from: datePicker.date)

            if isShmokeSelected == true {
               selectedDate = self.shmokeSessionHandler.selectedDate
            } else if isMatchSelected == true {
               selectedDate = self.matchSessionHandler.selectedDate
            } else if isDropSelected == true {
               selectedDate = self.dropSessionHandler.selectedDate
            } else if isSMOSelected == true {
               selectedDate = self.smoSessionHandler.selectedDate
            }

            if !selectedDate.isEmpty {
                let selectedMinimumDate = selectedDate.convertDateFormater(format: "MMMM dd, yyyy", utcToLocal: false, fromFormat: "MMMM dd, yyyy", localToutc: false)
                return selectedMinimumDate
            }else {
                return currentDate
            }

        case .time:
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.timeStyle = .long//"MMMM dd yyyy"
            var selectedTime = ""
            if isShmokeSelected == true {
                selectedTime = self.shmokeSessionHandler.selectedTime
            } else if isMatchSelected == true {
               selectedTime = self.matchSessionHandler.selectedTime
            } else if isDropSelected == true {
                selectedTime = self.dropSessionHandler.selectedTime
            } else if isSMOSelected == true {
                selectedTime = self.smoSessionHandler.selectedTime
            }

            if !selectedTime.isEmpty {
                let selectedMinimumDate = selectedTime.convertTimeFormater(format: "hh:mm a", utcToLocal: false, fromFormat: "hh:mm a", localToutc: false)
                return selectedMinimumDate
            }else {
                return currentDate
            }

        default:
            break
        }
return currentDate
    }
    @objc func datePickerDidChange(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()

        guard let enumVal = HomeViewSections.init(rawValue: datePicker.tag) else {
            return
        }
        switch enumVal {
        case .date:
            dateFormatter.dateFormat = "MMMM dd, yyyy"//"MMMM dd yyyy"
            let orderDateString = dateFormatter.string(from: datePicker.date)
            if orderDateString.count > 0 {
                print(orderDateString)
            }
            if isShmokeSelected == true {
                self.shmokeSessionHandler.selectedDate = orderDateString
            } else if isMatchSelected == true {
                self.matchSessionHandler.selectedDate = orderDateString
            } else if isDropSelected == true {
                self.dropSessionHandler.selectedDate = orderDateString
            } else if isSMOSelected == true {
                self.smoSessionHandler.selectedDate = orderDateString
            }
        case .time:
            dateFormatter.dateFormat = "hh:mm a"
            dateFormatter.timeStyle = .long//"MMMM dd yyyy"
            let orderDateString = dateFormatter.string(from: datePicker.date)
            if orderDateString.count > 0 {
                print(orderDateString)
            }
            if isShmokeSelected == true {
                self.shmokeSessionHandler.selectedTime = orderDateString
            } else if isMatchSelected == true {
                self.matchSessionHandler.selectedTime = orderDateString
            } else if isDropSelected == true {
                self.dropSessionHandler.selectedTime = orderDateString
            } else if isSMOSelected == true {
                self.smoSessionHandler.selectedTime = orderDateString
            }

        default:
            break
        }
    }
    func setDatePickerToTextFieldInputAccessoryView(textfield: UITextField, mode: UIDatePickerMode) {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: 216.0))
        datePicker.tag = textfield.tag
        if mode == .date {
            let minimumOrderDate = Date()//self.getMinimumDateToBeSelect(forType: datePicker.tag)
            datePicker.minimumDate = minimumOrderDate
        }
        datePicker.date = self.getMinimumDateToBeSelect(forType: datePicker.tag)
        datePicker.datePickerMode = mode
        datePicker.addTarget(self, action: #selector(self.datePickerDidChange(datePicker:)), for: .valueChanged)
        datePicker.backgroundColor = UIColor.backgroundGrey
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneButtonAction(sender:)))
        doneButton.tag = textfield.tag
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: screenHeight , width: screenWidth, height: 44.0))
        toolBar.barStyle = .default
        toolBar.items = [flexibleSpace, doneButton]
        textfield.inputAccessoryView = toolBar
        textfield.inputView = datePicker
    }
}
extension HomeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let enumVal = HomeViewSections.init(rawValue: pickerView.tag) else {
            return
        }
        switch enumVal {
        case .seshType:
            let val =  Common.share.getSeshTypeList()[row]
             if isShmokeSelected == true {
                self.shmokeSessionHandler.selectedSeshType = val
             } else if isMatchSelected == true {
                self.matchSessionHandler.selectedSeshType = val
             } else if isDropSelected == true {
                self.dropSessionHandler.selectedSeshType = val
             } else if isSMOSelected == true {
                self.smoSessionHandler.selectedSeshType = val
            }
        case .strain:
            let val = Common.share.getStrainTypeList()[row]
             if isShmokeSelected == true {
                self.shmokeSessionHandler.selectedStrainType = val
             } else if isMatchSelected == true {
                self.matchSessionHandler.selectedStrainType = val
             } else if isDropSelected == true {
                self.dropSessionHandler.selectedStrainType = val
             }
        case .point:
            let val = Common.share.getPointsTypeList()[row]
             if isDropSelected == true {
                self.dropSessionHandler.selectedPointType = val
            }
        case .utensils:
            let val =  Common.share.getUtensilTypeList()[row]
            if isShmokeSelected == true {
                self.shmokeSessionHandler.selectedUtensilType = val
            } else if isMatchSelected == true {
                self.matchSessionHandler.selectedUtensilType = val
            } else if isDropSelected == true {
                self.dropSessionHandler.selectedUtensilType = val
            }
        case .reason:
            let val = Common.share.getReasonsTypeList()[row]
             if isSMOSelected == true {
                self.smoSessionHandler.selectedReasonsType = val
            }
        case .gram:
            let val = Common.share.getGramTypeList()[row]
             if isMatchSelected == true {
                self.matchSessionHandler.selectedGramType = val
            }
        default:
            break
        }
    }
}
extension HomeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        guard let enumVal = HomeViewSections.init(rawValue: pickerView.tag) else {
            return 0
        }
        switch enumVal {
        case .seshType:
            return Common.share.getSeshTypeList().count
        case .strain:
             return Common.share.getStrainTypeList().count
        case .point:
            return Common.share.getPointsTypeList().count
        case .utensils:
            return Common.share.getUtensilTypeList().count
        case .reason:
            return Common.share.getReasonsTypeList().count
        case .gram:
            return Common.share.getGramTypeList().count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let enumVal = HomeViewSections.init(rawValue: pickerView.tag) else {
            return ""
        }
        switch enumVal {
        case .seshType:
            return Common.share.getSeshTypeList()[row]
        case .strain:
            return Common.share.getStrainTypeList()[row]
        case .point:
            return Common.share.getPointsTypeList()[row]
        case .utensils:
            return Common.share.getUtensilTypeList()[row]
        case .reason:
            return Common.share.getReasonsTypeList()[row]
        case .gram:
            return Common.share.getGramTypeList()[row]
        default:
            return ""
        }
    }
}
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag >= addBuddyBaseTag {
            if !textField.text!.isEmpty  {
                self.addBuddy(with: textField.text!, at: textField.tag)
            }
        } else if textField.tag == kLocationTag {
            if !textField.text!.isEmpty  {
                self.addLocation(with: textField.text!)
            }
        }
       
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let current = (textField.text ?? "") as NSString
        let modified = current.replacingCharacters(in: range, with: string)
        print(modified)
        if modified == "" {
            // User presses backspace
            textField.deleteBackward()
            return false
        } else {
            // User presses a key or pastes
            textField.insertText(string.capitalized)
        }
        textField.text = modified
        return true
    }
}
extension HomeViewController: AcceptSessionViewProtocol {
    func crossButtonClicked() {
        self.removeSessionStatusPopUPVC(sessionType: .none, session: nil)
    }
    func viewSessionClicked(session: Session) {
        self.removeSessionStatusPopUPVC(sessionType: .addSession, session: session)
    }
    func seshDetailsButtonClick(session: Session) {
        self.removeSessionStatusPopUPVC(sessionType: .viewSession, session: session)
    }
}
extension HomeViewController: SessionDetailsViewProtocols{
    func seshUPButtonClicked(session: Session, type: SessionStatusDetailType) {
        if type != .addSession {
            self.removeSessionUPC(sessionDetailType: .approvedSession, session: session)
        } else {
             self.removeSessionUPC(sessionDetailType: .none,  session: nil)
        }
        
    }
    func crossSeshUPButtonClicked() {
        self.removeSessionUPC(sessionDetailType: .none,  session: nil)
    }
}
extension HomeViewController {
    
    func presentAcceptSessionPopUP(sessionDetailType: SessionStatusType, session: Session) {
        sessionStatusPopUPVC = SeshStatusViewController(nibName: "SeshStatusViewController", bundle: nil)
        sessionStatusPopUPVC?.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        sessionStatusPopUPVC?.view.alpha = 0.1
        sessionStatusPopUPVC?.modalPresentationStyle = .overCurrentContext
        self.present((sessionStatusPopUPVC)!, animated: false
            , completion: {
        })
        sessionStatusPopUPVC?.session = session
        sessionStatusPopUPVC?.setUPUI()
        sessionStatusPopUPVC.setSessionUPUI(sessionDetailType: sessionDetailType)
        sessionStatusPopUPVC?.view.transform = CGAffineTransform(translationX: 0, y: 0)
        self.transparentView = UIView()
        transparentView?.frame = self.view.frame
        transparentView?.backgroundColor =  UIColor.black.withAlphaComponent(0.3)
        transparentView?.alpha = 0.1
        self.view.addSubview(transparentView!)
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: UIViewAnimationOptions.transitionCrossDissolve,
                       animations: {
                        self.sessionStatusPopUPVC?.view.alpha = 1.0
                        self.transparentView?.alpha = 1.0
                        self.sessionStatusPopUPVC?.delegate = self
                        self.sessionStatusPopUPVC?.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
        }
        )
    }
    
    func removeSessionStatusPopUPVC(sessionType: SessionStatusDetailType, session: Session?) {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: UIViewAnimationOptions.transitionCrossDissolve,
                       animations: {
                        self.sessionStatusPopUPVC?.view.alpha = 0.1
                        self.transparentView?.alpha = 0.1
        },
                       completion: { finished in
                        self.dismiss(animated: false, completion: {
                            self.transparentView?.removeFromSuperview()
                            if sessionType != .none {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    self.openSeshUPSession(sessionType: sessionType, session: session!)
                                }
                            }
                        })
        }
        )
        
    }
    
    func openSeshUPSession(sessionType: SessionStatusDetailType, session: Session) {
        sessionDetailsPopUPVc = SessionDetailViewController(nibName: "SessionDetailViewController", bundle: nil)
        sessionDetailsPopUPVc?.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        sessionDetailsPopUPVc?.view.alpha = 0.1
        sessionDetailsPopUPVc?.modalPresentationStyle = .overCurrentContext
        
        sessionDetailsPopUPVc.session = session
        sessionDetailsPopUPVc?.view.transform = CGAffineTransform(translationX: 0, y: 0)
        self.transparentView = UIView()
        transparentView?.frame = self.view.frame
        transparentView?.backgroundColor =  UIColor.black.withAlphaComponent(0.3)
        transparentView?.alpha = 0.1
        sessionDetailsPopUPVc?.sessionDetailType = sessionType
        sessionDetailsPopUPVc.setUPUI()
        self.present((sessionDetailsPopUPVc)!, animated: false
            , completion: {
                self.sessionDetailsPopUPVc.reloadView()
        })
        
        
        self.view.addSubview(transparentView!)
        self.sessionDetailsPopUPVc.reloadView()
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: UIViewAnimationOptions.transitionCrossDissolve,
                       animations: {
                        
                        self.sessionDetailsPopUPVc?.view.alpha = 1.0
                        self.transparentView?.alpha = 1.0
                        self.sessionDetailsPopUPVc?.delegate = self
                        self.sessionDetailsPopUPVc?.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        
        }
        )
    }
    
    func removeSessionUPC(sessionDetailType: SessionStatusType, session: Session?) {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: UIViewAnimationOptions.transitionCrossDissolve,
                       animations: {
                        self.sessionStatusPopUPVC?.view.alpha = 0.1
                        self.transparentView?.alpha = 0.1
        },
                       completion: { finished in
                        self.dismiss(animated: false, completion: {
                            self.transparentView?.removeFromSuperview()
                            if sessionDetailType != .none {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    self.presentAcceptSessionPopUP(sessionDetailType: sessionDetailType, session: session!)
                                }
                            }
                        })
        }
        )
        
    }
}
