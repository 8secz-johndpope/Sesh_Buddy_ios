//
//  CreateUserViewController.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 06/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

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
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    
    
    var presenter: CreateUserPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStyle(.default)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setUPUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
    }
    
    func setUPUI(){
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
