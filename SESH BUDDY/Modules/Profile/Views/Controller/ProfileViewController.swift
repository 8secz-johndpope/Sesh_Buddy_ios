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
enum Gender:Int {
    case male
    case female
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
    var aboutMe = ""
    var characterLimit = 100
    let tagOfPlaceholderLabel = 200
    let kTagaboutMeTextView = 201
    let kTagprofileTextView = 202
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStyle(.default)
        self.setNavBarRightButton(type: .save)
        self.showMenuBarButton(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setUPUI()
        let barButton = self.navigationItem.rightBarButtonItem
        let btn = barButton?.customView as? UIButton
        btn?.addTarget(self, action: #selector(self.saveProfileDetailsButtonClicked), for: .touchUpInside)
        
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
                cell.setCellValue(type: .firstName)
                return cell
            case .lastName:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: editProfileInputTableViewCell) as? EditProfileInputTableViewCell else {
                    return UITableViewCell()
                }
                 cell.setCellValue(type: .lastName)
                return cell
            case .dateOfBirth:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: editProfileInputTableViewCell) as? EditProfileInputTableViewCell else {
                    return UITableViewCell()
                }
                cell.profileTextField.tag = indexPath.row
                self.setDatePickerToTextFieldInputAccessoryView(textfield: cell.profileTextField)
                 cell.setCellValue(type: .dateOfBirth)
                return cell
            case .gender:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: editProfileInputTableViewCell) as? EditProfileInputTableViewCell else {
                    return UITableViewCell()
                }
                cell.profileTextField.tag = indexPath.row
                self.setGenderPickerToTextfieldInputAccessoryView(textfield: cell.profileTextField)
                 cell.setCellValue(type: .gender)
                return cell
            case .aboutMe:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: textViewTableViewCell) as? TextViewTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.profileTextView.text = aboutMe
                cell.profileTextView.tag = kTagaboutMeTextView
                if aboutMe != "" {
                    cell.placeHolderLAbel.isHidden = true
                    cell.characterLimitLabel.text = "\(characterLimit-aboutMe.count)/\(characterLimit)"
                }else {
                    cell.characterLimitLabel.text = "Max 100 characters"
                }
                cell.placeHolderLAbel.tag = tagOfPlaceholderLabel
                cell.profileTextView.delegate = self
                return cell
            default:
                break
            }
            
        case .accountDetails:
            guard let rowVal = AccountDetailsSection.init(rawValue: indexPath.row) else {
                return UITableViewCell()
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: editProfileInputTableViewCell) as? EditProfileInputTableViewCell else {
                return UITableViewCell()
            }
            switch rowVal {
            case .userName: cell.setAccountDetails(type: .userName)
            case .favoritShope: cell.setAccountDetails(type: .favoritShope)
            case .emailAddress: cell.setAccountDetails(type: .emailAddress)
            default:
                break
            }
            return cell
        case .logout:
            break
        default:
            break
        }
        
        return UITableViewCell()
    }
    func getMinimumDateToBeSelect() -> Date {
        
        let currentDate = Date()
        var returnedDate = Date()
        returnedDate =  Calendar.current.date(byAdding: .year, value: -70, to: currentDate)!
        
        return returnedDate
    }
    
    func getMaximumDateToBeSelect() -> Date {
        
        let currentDate = Date()
        var returnedDate = Date()
        returnedDate =  Calendar.current.date(byAdding: .year, value: -18, to: currentDate)!
        
        return returnedDate
    }
    
    @objc func datePickerDidChange(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy, h:mm a"//"MMMM dd yyyy"
        let orderDateString = dateFormatter.string(from: datePicker.date)
        if orderDateString.count > 0 {
            print(orderDateString)
//            self.selectedDateNTime =  orderDateString
//            selectedDate = datePicker.date
        }
    }
     @objc func doneButtonAction(sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    func setDatePickerToTextFieldInputAccessoryView(textfield: UITextField){
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: 216.0))
        let minimumOrderDate = self.getMinimumDateToBeSelect()
        datePicker.minimumDate = minimumOrderDate
        datePicker.maximumDate = self.getMaximumDateToBeSelect()
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
    
    func setGenderPickerToTextfieldInputAccessoryView(textfield: UITextField) {
        let genderPicker = UIPickerView()
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
    
    @objc func saveProfileDetailsButtonClicked() {
     print("Save profile button")
    }
}

extension ProfileViewController: UIPickerViewDelegate {
    
}
extension ProfileViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.count.rawValue
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == Gender.male.rawValue {
            return "Male"
        } else {
            return "Female"
        }
    }
}

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == ProfileSections.profileInfo.rawValue {
            return 0
        }
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let view = Bundle.main.loadNibNamed("EditProfileHeaderCellTableViewCell", owner: self, options: nil)?[0] as? EditProfileHeaderCellTableViewCell {
            
            guard let enumVal = ProfileSections.init(rawValue: section) else {
                return UIView()
            }
            let textfieldFont = Fonts.mavenProRegular.getFont(14)
            view.headerLabel.font = textfieldFont
            switch enumVal {
            case .personalInfo:
                view.headerLabel.text = "Personal Information"
            case  .profileInfo:
                view.headerLabel.text = ""
            case .accountDetails:
                view.headerLabel.text = "Account Details"
            case .logout:
               view.headerLabel.text = "LOGOUT"
               let textfieldBoldFont = Fonts.mavenProBold.getFont(15)
               view.headerLabel.font = textfieldBoldFont
            default:
                view.headerLabel.text = ""
            }
            return view
        }
        return UIView()
    }
    
    
}

extension ProfileViewController: UITextViewDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView.tag == kTagaboutMeTextView {
            let thisIndexPath = IndexPath(row: PersonalInfoSection.aboutMe.rawValue, section: ProfileSections.personalInfo.rawValue)
            let cell = self.profileTableView.cellForRow(at: thisIndexPath) as? TextViewTableViewCell
            
            let currentText:NSString = textView.text as NSString
            let updatedText = currentText.replacingCharacters(in: range, with: text)
            
            let startHeight = textView.frame.size.height
            let calcHeight = textView.sizeThatFits(textView.frame.size).height  //iOS 8+ only
            
            if startHeight != calcHeight {
                
                UIView.setAnimationsEnabled(false) // Disable animations
                self.profileTableView.beginUpdates()
                self.profileTableView.endUpdates()
                UIView.setAnimationsEnabled(true)
                profileTableView?.scrollToRow(at: thisIndexPath,
                                              at: .bottom,
                                              animated: false)
            }
            aboutMe = updatedText
            let superViewOfTextView = textView.superview
            let placeHolderLabel = superViewOfTextView?.viewWithTag(tagOfPlaceholderLabel)
            if aboutMe.count == 0 {
                cell?.characterLimitLabel.text = "\(characterLimit)"
                if placeHolderLabel != nil {
                    placeHolderLabel!.isHidden = false
                }
            } else {
                if aboutMe.count <= characterLimit {
                     cell?.characterLimitLabel.text = "\(characterLimit-aboutMe.count)/\(characterLimit)"
                    if placeHolderLabel != nil {
                        placeHolderLabel!.isHidden = true
                    }
                }
                else {
                    return false
                }
            }
        }

        
        return true
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.tag == kTagaboutMeTextView {
            let thisIndexPath = IndexPath(row: PersonalInfoSection.aboutMe.rawValue, section: ProfileSections.personalInfo.rawValue)
            let cell = self.profileTableView.cellForRow(at: thisIndexPath) as? TextViewTableViewCell
            cell?.placeHolderLAbel.isHidden = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        aboutMe = textView.text
        
        let superViewOfTextView = textView.superview
        let placeHolderLabel = superViewOfTextView?.viewWithTag(tagOfPlaceholderLabel)
        if aboutMe.count == 0 {
            
            if placeHolderLabel != nil {
                placeHolderLabel!.isHidden = false
            }
        } else {
            if placeHolderLabel != nil {
                placeHolderLabel!.isHidden = true
            }
        }
        self.profileTableView.reloadData()
    }
    
    func updateHeightOfTextView(textview: UITextView) {
        if textview.tag == kTagaboutMeTextView {
            let indexPath = IndexPath(row: PersonalInfoSection.aboutMe.rawValue, section: ProfileSections.personalInfo.rawValue)
            let cell = self.profileTableView.cellForRow(at: indexPath) as? TextViewTableViewCell
            let startHeight = textview.frame.size.height
            let calcHeight = textview.sizeThatFits(textview.frame.size).height  //iOS 8+ only
            
            if startHeight != calcHeight {
                cell?.textviewHeightConstraint.constant = calcHeight
            }
        } else {
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        self.updateHeightOfTextView(textview: textView)
    }
}
