//
//  CreateUserViewController.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 06/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//
enum SignUpType {
    case facebook
    case snapchat
    case email
    case none
}
import UIKit
import REFrostedViewController

class CreateUserViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordSepratorView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailSepratorView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var createUserScrollView: UIScrollView!
    @IBOutlet weak var createUserContentView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var inputFieldsStackView: UIStackView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var joinNowButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameSeprator: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var lastNameSeprator: UIView!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameSeprator: UIView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    
    let TermsAndConditionURLString = ""
    let PrivacyPolicyURLString = ""
    var signUPType = SignUpType.none
    var firstName: String!
    var lastName: String!
    var userName: String!
    var emailString:String!
    var password: String!
    
    let kTagFirstName = 100
    let kTagLastName = 101
    let kTagUserName = 102
    let kTagEmail = 103
    let kTagpassword = 104
    
    @IBOutlet weak var termsAndConditionTextView: UITextView!
    
    var presenter: CreateUserPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStyle(.default)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
        setUPUI()
        setUPData()
    }
    
    func setUPData() {
        if signUPType == .facebook {
            guard let fbProfile = UserDefaults.standard.object(forKey: kFBDetailInfo) as? [String: Any] else {
                return
            }
            if let fbFirstName = fbProfile["first_name"] as? String, !fbFirstName.isEmpty {
                self.firstName = fbFirstName
                self.firstNameTextField.text = self.firstName.capitalized
                
            }
            if let fbFirstName = fbProfile["last_name"] as? String, !fbFirstName.isEmpty {
                self.lastName = fbFirstName
                self.lastNameTextField.text = self.lastName.capitalized
            }
            if let fbFirstName = fbProfile["username"] as? String, !fbFirstName.isEmpty {
                self.userName = fbFirstName
                self.userNameTextField.text = self.userName.capitalized
            }
            
        } else if signUPType == .snapchat {
            
        } else {
            
        }
        
        
        
       // self.emailTextField.text = self.emailString.capitalized
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
    }
    override func viewWillDisappear(_ animated: Bool) {
         // self.changeNavBarColor(.clear)
         guard let rootController = appDelegate.window!.rootViewController as? REFrostedViewController, let navController = rootController.contentViewController as? UINavigationController else {
            return
        }
        navController.setNavigationBarHidden(true, animated: false)
        super.viewWillDisappear(animated)
    }
    func setUPUI(){
        setUPTermsAndConditionTextView()
        self.termsAndConditionTextView.delegate = self
        self.termsAndConditionTextView.textAlignment = .left
        let textfieldFont = Fonts.mavenProRegular.getFont(16)
        let subTitleFont = Fonts.mavenProRegular.getFont(12)
        self.firstNameTextField.font = textfieldFont
        self.lastNameTextField.font = textfieldFont
        self.userNameTextField.font = textfieldFont
        self.passwordTextField.font = textfieldFont
        self.emailTextField.font = textfieldFont
        
        self.firstNameTextField.textColor = .white
        self.lastNameTextField.textColor = .white
        self.userNameTextField.textColor = .white
        self.emailTextField.textColor = .white
        self.passwordTextField.textColor = .white
        
        self.firstNameLabel.textColor = .white
        self.lastNameLabel.textColor = .white
        self.userNameLabel.textColor = .white
        self.emailLabel.textColor = .white
        self.passwordLabel.textColor = .white
        
        self.firstNameLabel.font = subTitleFont
        self.lastNameLabel.font = subTitleFont
        self.userNameLabel.font = subTitleFont
        self.emailLabel.font = subTitleFont
        self.passwordLabel.font = subTitleFont
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.userNameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.emailTextField.delegate = self
        
        self.firstNameTextField.tag = kTagFirstName
        self.lastNameTextField.tag = kTagLastName
        self.userNameTextField.tag = kTagUserName
        self.passwordTextField.tag = kTagpassword
        self.emailTextField.tag = kTagEmail
        
        joinNowButton.backgroundColor = UIColor.buttonColor
        
        switch signUPType {
        case .facebook:
            self.headerLabel.text = "CREATE USER"
            self.passwordView.isHidden = true
            self.emailView.isHidden = true
        case .snapchat:
            self.passwordView.isHidden = true
            self.emailView.isHidden = true
            self.headerLabel.text = "CREATE USER"
        case .email:
            self.passwordView.isHidden = false
            self.emailView.isHidden = false
            self.headerLabel.text = "SIGN UP"
        default:
            break
        }
        
    }
    
    func setUPTermsAndConditionTextView() {
        termsAndConditionTextView.isEditable = false
        termsAndConditionTextView.attributedText = self.getTermsAndConditionStringFrom(firstString: "By tapping Join Now & Accept, You agree to the" + " ", termsString: "Terms of Service" + " ", andString: "and" + " ", privacyPolicyString: "Privacy Policy")
        let linkAttributes = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.orange,
            NSAttributedStringKey.underlineColor.rawValue: UIColor.orange,
            NSAttributedStringKey.underlineStyle.rawValue: NSUnderlineStyle.styleSingle.rawValue ] as [String : Any]
        termsAndConditionTextView.linkTextAttributes = linkAttributes
    }
    
    
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        //        UIApplication.shared.open(URL, options: , completionHandler: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        return true
    }
    
    func getTermsAndConditionStringFrom(firstString: String, termsString: String, andString: String, privacyPolicyString: String)-> NSMutableAttributedString {
        let combinedString = firstString + termsString + andString + privacyPolicyString
        let attributedTermsAndConditions = NSMutableAttributedString(string: combinedString)
        let rangeOfFirstString = (combinedString as NSString).range(of: firstString)
        let rangeOfTermsString = (combinedString as NSString).range(of: termsString)
        let rangeOfAndString = (combinedString as NSString).range(of: andString)
        let rangeOfPrivacyString = (combinedString as NSString).range(of: privacyPolicyString)
        attributedTermsAndConditions.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: rangeOfFirstString)
        attributedTermsAndConditions.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: rangeOfAndString)
        attributedTermsAndConditions.addAttribute(NSAttributedStringKey.font, value: Fonts.mavenProRegular.getFont(12.5), range: rangeOfFirstString)
        attributedTermsAndConditions.addAttribute(NSAttributedStringKey.font, value: Fonts.mavenProRegular.getFont(13), range: rangeOfTermsString)
        attributedTermsAndConditions.addAttribute(NSAttributedStringKey.font, value: Fonts.mavenProRegular.getFont(12.5), range: rangeOfAndString)
        attributedTermsAndConditions.addAttribute(NSAttributedStringKey.font, value: Fonts.mavenProRegular.getFont(13), range: rangeOfPrivacyString)
        let labelAtributes:[NSAttributedStringKey : Any]  = [
            NSAttributedStringKey.foregroundColor: UIColor.orange,
            NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue,
            NSAttributedStringKey.underlineColor: UIColor.orange
        ]
        attributedTermsAndConditions.addAttributes(labelAtributes, range: rangeOfTermsString)
        attributedTermsAndConditions.addAttributes(labelAtributes, range: rangeOfPrivacyString)
        attributedTermsAndConditions.addAttribute(NSAttributedStringKey.link, value: URL(string: TermsAndConditionURLString) ?? "", range: rangeOfTermsString)
        attributedTermsAndConditions.addAttribute(NSAttributedStringKey.link, value: URL(string: PrivacyPolicyURLString) ?? "", range: rangeOfPrivacyString)
        return attributedTermsAndConditions
        
    }
    @IBAction func joinNowButtonClicked(_ sender: Any) {
        self.presenter?.createUserNuttonClicked()
    }
    
}
extension CreateUserViewController: CreateUserViewProtocol {
    func onError(value: String) {
        
    }
    func showAlert(_ string: String) {
        
    }
}
extension CreateUserViewController: UITextFieldDelegate {
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
        if textField.tag == self.kTagFirstName {
            self.firstName = modified
        } else if textField.tag == self.kTagFirstName {
            self.lastName = modified
        } else if textField.tag == self.kTagUserName {
            self.userName = modified
        } else if textField.tag == self.kTagEmail {
            self.lastName = modified
        }
        
        return true
    }
}
