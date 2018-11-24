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
    
    var presenter: LoginPresenterProtocol?
    
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
        
        loginWithEmailButton.backgroundColor = UIColor.buttonColor
    }
    
    @IBAction func loginWithEmailButtonAction(_ sender: Any) {
        self.presenter?.didTapAtLoginWithEmail()
    }
}
extension LoginWithEmailViewController: LoginViewProtocol {
    func onError(value: String) {
        
    }
    func showAlert(_ string: String) {
        UIAlertController.presentAlert(title: nil, message: string, style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
    }
}
extension LoginWithEmailViewController: UITextFieldDelegate {
    
}
