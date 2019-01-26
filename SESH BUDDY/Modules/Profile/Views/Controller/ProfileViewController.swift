//
//  ProfileViewController.swift
//  SESH BUDDY
//
//  Created by Apple on 12/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//
enum ImageType: Int {
    case profile
    case backgroundProfile
    case none
}
import UIKit
import Alamofire
import AlamofireImage
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

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate  {
    
    
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
    let kTagFirstName = 300
    let kTagLastName = 301
    let kTagUserName = 400
    let kTagFavoritStrain = 401
    
    
    
    var selectedDateNTime = ""
    var selectedDate: Date!
    var selectedGender = ""
    var profileImage: UIImage!
    var backgroundProfileImage: UIImage!
    var selectedImageType = ImageType.none
    let nullDob = "0000-00-00"
    override func viewDidLoad() {
        super.viewDidLoad()
         SelectImage.sharedInstance.delegate = self
        self.changeStyle(.default)
        self.setNavBarRightButton(type: .save)
        let btn = BarButton(type: .custom)
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = Fonts.mavenProMedium.getFont(16)
        btn.addTarget(self, action: #selector(self.saveButtonAction), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = barButton
        
        self.showMenuBarButton(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setUPUI()
      
        registerNib()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
    }
    @objc func saveButtonAction() {
        self.presenter?.didTapAtEditProfile()
    }
    func registerNib() {
        self.profileTableView.registerCellFrom(editProfileInputTableViewCell)
        self.profileTableView.registerCellFrom(textViewTableViewCell)
        self.profileTableView.registerCellFrom(editProfileInputTableViewCell)
        self.profileTableView.registerCellFrom(profileInfoTableViewCell)
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
    }
    func setUPUI(){
        self.presenter?.firstName = ApplicationData.shared.checkLoginData()  == true ? ApplicationData.shared.getLoginData().firstName : ""
        self.presenter?.lastName = ApplicationData.shared.checkLoginData()  == true ? ApplicationData.shared.getLoginData().lastName : ""
        self.presenter?.userName = ApplicationData.shared.checkLoginData()  == true ? ApplicationData.shared.getLoginData().userName : ""
        self.presenter?.dob = ApplicationData.shared.checkLoginData()  == true ? ApplicationData.shared.getLoginData().dob : ""
        
        if self.presenter!.dob == nullDob {
            self.presenter?.dob = ""
        }
        self.presenter?.coverPic = ApplicationData.shared.checkLoginData()  == true ? ApplicationData.shared.getLoginData().coverPic : ""
        self.presenter?.profilePic = ApplicationData.shared.checkLoginData()  == true ? ApplicationData.shared.getLoginData().profilePic : ""
        self.presenter?.gender = ApplicationData.shared.checkLoginData()  == true ? ApplicationData.shared.getLoginData().gender : 0
        
        self.presenter?.aboutMe = ApplicationData.shared.checkLoginData()  == true ? ApplicationData.shared.getLoginData().aboutMe : ""
        self.presenter?.favoritStrain = ApplicationData.shared.checkLoginData()  == true ? ApplicationData.shared.getLoginData().favoriteStrain : ""
        self.profileTableView.reloadData()
    }
    
    // MARK: Logout from app
    @objc func logoutFromApp() {
        self.frostedViewController.hideMenuViewController()
        self.presenter?.didTapAtLogout()
    }
    
    @objc func editProfileImageButtonAction() {
        selectedImageType = ImageType.profile
        SelectImage.sharedInstance.selectImage(self, folderPath: "", fileName: "")
    }
    
    @objc func editProfileBackgroundButtonAction() {
        selectedImageType = ImageType.backgroundProfile
        SelectImage.sharedInstance.selectImage(self, folderPath: "", fileName: "")
    }
}
extension ProfileViewController: EditProfileViewProtocol {
    func onError(value: String) {
        UIAlertController.presentAlert(title: nil, message: value, style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
    }
    func showAlert(_ string: String) {
        UIAlertController.presentAlert(title: nil, message: string, style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
    }
    func reloadView() {
        setUPUI()
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
            if ApplicationData.shared.checkLoginData(), ApplicationData.shared.getLoginData().profilePic.count > 0 {
                let profilePic = ApplicationData.shared.getLoginData().profilePic
                let url = URL(string: profilePic!)
                cell.profileImageView.af_setImage(withURL: url!, placeholderImage: Icons.profilePlaceHolder, filter: nil, progress: nil, progressQueue: .main, imageTransition: .crossDissolve(0.1), runImageTransitionIfCached: true) { (nil) in
                }
            } else {
                cell.profileImageView.image = Icons.profilePlaceHolder
            }
            
            if ApplicationData.shared.checkLoginData(), ApplicationData.shared.getLoginData().coverPic.count > 0 {
                cell.descriptionTextView.text = ApplicationData.shared.getLoginData().aboutMe
                let profilePic = ApplicationData.shared.getLoginData().coverPic
                let url = URL(string: profilePic!)
                cell.bgImageView.af_setImage(withURL: url!, placeholderImage: Icons.splash, filter: nil, progress: nil, progressQueue: .main, imageTransition: .crossDissolve(0.1), runImageTransitionIfCached: true) { (nil) in
                }
            } else {
                 cell.descriptionTextView.text = ""
                cell.bgImageView.image = Icons.splash
            }
            cell.editProfileImageButton.addTarget(self, action: #selector(self.editProfileImageButtonAction), for: .touchUpInside)
            cell.editDescriptionButton.addTarget(self, action: #selector(self.editProfileBackgroundButtonAction), for: .touchUpInside)
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
                cell.profileTextField.delegate = self
                cell.profileTextField.tag = kTagFirstName
                cell.setCellValue(type: .firstName)
                cell.profileTextField.text = self.presenter!.firstName!
                return cell
            case .lastName:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: editProfileInputTableViewCell) as? EditProfileInputTableViewCell else {
                    return UITableViewCell()
                }
                cell.profileTextField.delegate = self
                cell.profileTextField.tag = kTagLastName
                cell.setCellValue(type: .lastName)
                cell.profileTextField.text = self.presenter!.lastName!
                return cell
            case .dateOfBirth:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: editProfileInputTableViewCell) as? EditProfileInputTableViewCell else {
                    return UITableViewCell()
                }
                cell.profileTextField.tag = indexPath.row
                self.setDatePickerToTextFieldInputAccessoryView(textfield: cell.profileTextField)
                 //cell.profileTextField.text = self.selectedDateNTime
                cell.profileTextField.text = self.presenter!.dob!
                 cell.setCellValue(type: .dateOfBirth)
                return cell
            case .gender:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: editProfileInputTableViewCell) as? EditProfileInputTableViewCell else {
                    return UITableViewCell()
                }
                cell.profileTextField.text = self.presenter!.gender == 0 ? "Male" : "Female"//self.selectedGender
                cell.profileTextField.tag = indexPath.row
                self.setGenderPickerToTextfieldInputAccessoryView(textfield: cell.profileTextField)
                 cell.setCellValue(type: .gender)
                return cell
            case .aboutMe:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: textViewTableViewCell) as? TextViewTableViewCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.profileTextView.text = self.presenter!.aboutMe//aboutMe
                cell.profileTextView.tag = kTagaboutMeTextView
                if self.presenter!.aboutMe != "" {
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
            case .userName:
                cell.profileTextField.delegate = self
                cell.profileTextField.tag = kTagUserName
                cell.setAccountDetails(type: .userName)
                cell.profileTextField.text = self.presenter!.userName!
            case .favoritShope:
                cell.profileTextField.delegate = self
                cell.profileTextField.tag = kTagFavoritStrain
                cell.setAccountDetails(type: .favoritShope)
                cell.profileTextField.text = self.presenter!.favoritStrain!
            case .emailAddress:
                cell.setAccountDetails(type: .emailAddress)
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
//        var returnedDate = Date()
//        returnedDate =  Calendar.current.date(byAdding: .year, value: 0, to: currentDate)!
        
        return currentDate
    }
    
    @objc func datePickerDidChange(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"//"MMMM dd yyyy"
        let orderDateString = self.getDateString(from: datePicker.date)
        if orderDateString.count > 0 {
            print(orderDateString)
            self.selectedDateNTime =  orderDateString
            self.presenter?.dob = orderDateString
            selectedDate = datePicker.date
        }
    }
    func getDateString(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"//"MMMM dd yyyy"
        let orderDateString = dateFormatter.string(from: from)
        return orderDateString
    }
     @objc func doneButtonAction(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        guard let rowVal = PersonalInfoSection.init(rawValue: sender.tag) else {
            return
        }
        if rowVal == .dateOfBirth {
            if self.selectedDateNTime.isEmpty {
                self.selectedDate = self.getMaximumDateToBeSelect()
                self.selectedDateNTime = self.getDateString(from: self.selectedDate)
                self.presenter?.dob = self.selectedDateNTime
            }
        }else {
            if self.selectedGender.isEmpty {
                selectedGender = "Male"
                self.presenter?.gender = 0
            }
        }
       
        self.profileTableView.reloadData()
    }
    func setDatePickerToTextFieldInputAccessoryView(textfield: UITextField){
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: 216.0))
        datePicker.datePickerMode = .date
        let minimumOrderDate = self.getMinimumDateToBeSelect()
        datePicker.maximumDate = self.getMaximumDateToBeSelect()
        datePicker.minimumDate = minimumOrderDate
        if self.selectedDate != nil {
            datePicker.date = self.selectedDate
        } else {
            datePicker.date = datePicker.maximumDate!
        }
        
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == Gender.male.rawValue {
            self.selectedGender = "Male"
            self.presenter?.gender = Gender.male.rawValue
        } else {
            self.selectedGender =  "Female"
            self.presenter?.gender = Gender.female.rawValue
        }
    }
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
               view.headerButton.addTarget(self, action: #selector(self.logoutFromApp), for: .touchUpInside )
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
        self.presenter?.aboutMe = aboutMe
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

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField.tag == self.kTagEmail {
//            self.passwordTextField.becomeFirstResponder()
//        } else {
//            self.view.endEditing(true)
//        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let current = (textField.text ?? "") as NSString
        let modified = current.replacingCharacters(in: range, with: string)
        print(modified)
        if modified == "" {
            // User presses backspace
            textField.deleteBackward()
            return false
        }
        switch textField.tag {
        case kTagFirstName:
            self.presenter?.firstName = modified
        case kTagLastName:
            self.presenter?.lastName = modified
        case kTagUserName:
            self.presenter?.userName = modified
        case kTagFavoritStrain:
            self.presenter?.favoritStrain = modified
        default:
            break
        }
        
        return true
    }
}
extension ProfileViewController: SavedImageDelegate {
    func imageSelectedSuccesfully(_ filePath: String, image: UIImage) {
        if selectedImageType == .profile {
            self.profileImage = image
            self.presenter?.editProfileImage(image: self.profileImage, type: .profile)
        } else {
            self.backgroundProfileImage = image
             self.presenter?.editProfileImage(image: self.backgroundProfileImage, type: .backgroundProfile)
        }
        self.profileTableView.reloadData()
    }
}
