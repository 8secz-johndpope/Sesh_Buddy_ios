//
//  LoginOptionsViewController.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 03/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit
enum LoginButtons {
    case facebook
    case snapchat
    case email
}


class LoginOptionsViewController: UIViewController {

    @IBOutlet weak var loginWithEmailButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginOptionsScrollView: UIScrollView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var backgroungImageView: UIImageView!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var snapchatLoginButton: UIButton!
    @IBOutlet weak var loginInfoLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var leftSepratorView: UIView!
    @IBOutlet weak var rightSepratorView: UIView!
    @IBOutlet weak var signUpEmailButton: UIButton!
    
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = newBackButton
        setUPUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.changeNavBarColor(.clear)
    }
    
    func setUPUI(){
        let buttonRadius: CGFloat = 3.0
        facebookLoginButton.layer.cornerRadius = buttonRadius
        snapchatLoginButton.layer.cornerRadius = buttonRadius
        signUpEmailButton.layer.cornerRadius = buttonRadius
        loginWithEmailButton.layer.cornerRadius = buttonRadius
        
        signUpEmailButton.backgroundColor = UIColor.themeNavBarColor
        loginWithEmailButton.backgroundColor = UIColor.themeNavBarColor
        facebookLoginButton.setAttributedTitle(self.getAttributedString(withFirst: "Login with", withSecond: " Facebook ", image: Icons.facebook, type: .facebook), for: .normal)
        snapchatLoginButton.setAttributedTitle(self.getAttributedString(withFirst: "Login with", withSecond: " Snapchat ", image: Icons.snapchat, type: .snapchat), for: .normal)
        loginInfoLabel.font = Fonts.mavenProRegular.getFont(12)
        loginInfoLabel.text = "SeshBuddies respects your privacy. Name and Emails aren't displayed publicly, and nothing posted to your Facebook and Snapchat account without permission."
        signUpEmailButton.setAttributedTitle(self.getAttributedString(withFirst: "Sign up with", withSecond: " Email ", image: nil, type: .
            email), for: .normal)
        loginWithEmailButton.setAttributedTitle(self.getAttributedString(withFirst: "Login with", withSecond: " Email ", image: nil, type: .
            email), for: .normal)
    }
    
    func getAttributedString(withFirst: String, withSecond: String , image: UIImage?, type: LoginButtons)-> NSMutableAttributedString {
        let firstString = NSMutableAttributedString(string: withFirst).lineSpacing(2)
        let secondString = NSMutableAttributedString(string: withSecond).lineSpacing(2)
        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        if image != nil {
            image1Attachment.image = image
        }
        let imageString = NSAttributedString(attachment: image1Attachment)
        switch type {
        case .facebook:
            image1Attachment.bounds = CGRect(x: 0, y: -4, width: 10, height: 16)
            firstString.color(.white).font(Fonts.mavenProRegular.getFont(15)).alignment(.center)
            secondString.color(.white).font(Fonts.mavenProBold.getFont(15)).alignment(.center)
        case .snapchat:
            image1Attachment.bounds = CGRect(x: 0, y: -4, width: 15, height: 18)
            firstString.color(.black).font(Fonts.mavenProRegular.getFont(15)).alignment(.center)
            secondString.color(.black).font(Fonts.mavenProBold.getFont(15)).alignment(.center)
        case .email:
            firstString.color(.white).font(Fonts.mavenProRegular.getFont(15)).alignment(.center)
            secondString.color(.white).font(Fonts.mavenProBold.getFont(15)).alignment(.center)
             return firstString + secondString
        }
        return firstString + secondString + imageString
    }

    override func viewDidLayoutSubviews() {
       // self.navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLayoutSubviews()
    }
    @IBAction func loginWithEmailButtonAction(_ sender: Any) {
    }
    
    @IBAction func loginWithFacebookButtonclicked(_ sender: Any) {
        self.presenter?.didTapAtLoginWithFacebook()
    }
    
    @IBAction func loginWithSnapChatButtonClicked(_ sender: Any) {
        self.presenter?.didTapAtLoginWithSnapChat()
    }
    
    @IBAction func loginInWithEmailButtonClicked(_ sender: Any) {
        self.presenter?.didTapAtRegisterButton()
    }
}
extension LoginOptionsViewController: LoginViewProtocol {
    func onError(value: String) {
        
    }
    
    func showAlert(_ string: String) {
        UIAlertController.presentAlert(title: nil, message: string, style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
    }
}
