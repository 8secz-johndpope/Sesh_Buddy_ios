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
    
    let homeButtonTableViewCell = "HomeButtonTableViewCell"
    let sessionTypeTableViewCell = "SessionTypeTableViewCell"
    let currentSessionTableViewCell = "CurrentSessionTableViewCell"
    
    let shmokeIdentifier = "SHMOKEHomeButtonTableViewCell"
    let matchIdentifier = "MATCHHomeButtonTableViewCell"
    let dropIdentifier = "DROPHomeButtonTableViewCell"
    let smoIdentifier = "SMOHomeButtonTableViewCell"
    
    
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
            return sessionTypeCell
        case .utensils:
             updateTableViewHeight()
             sessionTypeCell.sessionTextField.tag = indexPath.section
             self.setPickerToTextfieldInputAccessoryView(textfield: sessionTypeCell.sessionTextField)
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
        let totalHeight = screenHeight - CGFloat(navigationBarHeight)
        if contentHeight >= totalHeight {
            self.bottomTableViewConstraint.constant = 0
            self.topConstraintTableView.constant = 0
            self.tableViewHeightConstraint.constant = totalHeight
        } else {
            let margin = ((totalHeight) - contentHeight)/2
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
            cell.sessionTextField.text = ""
        case .buddiesList:
            cell.sessionTextField.text = ""
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
        self.homeTableView.reloadData()
    }
    func getMinimumDateToBeSelect() -> Date {
        let currentDate = Date()
        //var returnedDate = Date()
       // returnedDate =  Calendar.current.date(byAdding: .year, value: -70, to: currentDate)!
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
            dateFormatter.dateFormat = "HH : mm"//"MMMM dd yyyy"
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
            let minimumOrderDate = self.getMinimumDateToBeSelect()
            datePicker.minimumDate = minimumOrderDate
        }
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
