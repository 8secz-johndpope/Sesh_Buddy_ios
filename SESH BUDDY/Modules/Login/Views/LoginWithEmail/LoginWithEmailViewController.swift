//
//  LoginWithEmailViewController.swift
//  SESH BUDDY
//
//  Created by test on 13/11/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit
import REFrostedViewController

class LoginWithEmailViewController: UIViewController {
    @IBOutlet weak var loginContainerView: UIView!
    
    @IBOutlet weak var privacyPolicyTextView: UITextView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailSeprator: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordSeprator: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var loginWithEmailButton: UIButton!
    let TermsAndConditionURLString = ""
    let PrivacyPolicyURLString = ""
    var presenter: LoginPresenterProtocol?
    let kTagEmail = 100
    let kTagPassword = 101
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStyle(.default)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
        setUPUI()
        setUPTermsAndConditionTextView()
    }
    func setUPTermsAndConditionTextView() {
        privacyPolicyTextView.isEditable = false
        privacyPolicyTextView.attributedText = self.getTermsAndConditionStringFrom(firstString: "By tapping Join Now & Accept, You agree to the" + " ", termsString: "Terms of Service" + " ", andString: "and" + " ", privacyPolicyString: "Privacy Policy")
        let linkAttributes = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.orange,
            NSAttributedStringKey.underlineColor.rawValue: UIColor.orange,
            NSAttributedStringKey.underlineStyle.rawValue: NSUnderlineStyle.styleSingle.rawValue ] as [String : Any]
        privacyPolicyTextView.linkTextAttributes = linkAttributes
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
        let textfieldFont = Fonts.mavenProRegular.getFont(16)
        let subTitleFont = Fonts.mavenProRegular.getFont(12)
        self.passwordTextField.font = textfieldFont
        self.emailTextField.font = textfieldFont
        
        self.emailTextField.textColor = .white
        self.passwordTextField.textColor = .white
        
        self.emailLabel.textColor = .white
        self.passwordLabel.textColor = .white
        
        self.emailLabel.font = subTitleFont
        self.passwordLabel.font = subTitleFont
        
        self.passwordTextField.delegate = self
        self.emailTextField.delegate = self
        self.emailTextField.tag = kTagEmail
        self.passwordTextField.tag = kTagPassword
        
        loginWithEmailButton.backgroundColor = UIColor.buttonColor
    }
    
    @IBAction func loginWithEmailButtonAction(_ sender: Any) {
       self.presenter?.didTapAtLoginWithEmail()
    }
}
extension LoginWithEmailViewController: LoginViewProtocol {
    func onError(value: String) {
        UIAlertController.presentAlert(title: nil, message: value, style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
    }
    func showAlert(_ string: String) {
        UIAlertController.presentAlert(title: nil, message: string, style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
    }
}
extension LoginWithEmailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         if textField.tag == self.kTagEmail {
            self.passwordTextField.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
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
        if textField.tag == self.kTagEmail {
            self.presenter?.email = modified
        } else {
            self.presenter?.password = modified
        }
        
        return true
    }
}
