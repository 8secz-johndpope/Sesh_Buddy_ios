//
//  CreateUserViewController.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 06/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

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
    
    @IBOutlet weak var termsAndConditionTextView: UITextView!
    
    var presenter: CreateUserPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStyle(.default)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
        setUPUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
    }
    override func viewWillDisappear(_ animated: Bool) {
          self.changeNavBarColor(.clear)
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
        
        self.firstNameTextField.textColor = .white
        self.lastNameTextField.textColor = .white
        self.userNameTextField.textColor = .white
        
        self.firstNameLabel.textColor = .white
        self.lastNameLabel.textColor = .white
        self.userNameLabel.textColor = .white
        
        self.firstNameLabel.font = subTitleFont
        self.lastNameLabel.font = subTitleFont
        self.userNameLabel.font = subTitleFont
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.userNameTextField.delegate = self
        
        joinNowButton.backgroundColor = UIColor.themeNavBarColor
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
    
}
