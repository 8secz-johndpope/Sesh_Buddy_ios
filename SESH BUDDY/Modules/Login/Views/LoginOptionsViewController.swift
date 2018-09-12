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
    
    func setUPUI(){
        let buttonRadius: CGFloat = 3.0
        facebookLoginButton.layer.cornerRadius = buttonRadius
        snapchatLoginButton.layer.cornerRadius = buttonRadius
        signUpEmailButton.layer.cornerRadius = buttonRadius
        
        facebookLoginButton.setAttributedTitle(self.getAttributedString(withFirst: "Login with", withSecond: " Facebook ", image: Icons.facebook, type: .facebook), for: .normal)
        snapchatLoginButton.setAttributedTitle(self.getAttributedString(withFirst: "Login with", withSecond: " Snapchat ", image: Icons.snapchat, type: .snapchat), for: .normal)
        loginInfoLabel.font = Fonts.mavenProRegular.getFont(12)
        loginInfoLabel.text = "SeshBuddies respects your privacy. Name and Emails aren't displayed publicaly, and nothing posted to your Facebook and Snapchat account without permission."
        signUpEmailButton.setTitle("Sign up with Email", for: .normal)
    }
    
    
    func getAttributedString(withFirst: String, withSecond: String , image: UIImage, type: LoginButtons)-> NSMutableAttributedString {
        let firstString = NSMutableAttributedString(string: withFirst).lineSpacing(2)
        let secondString = NSMutableAttributedString(string: withSecond).lineSpacing(2)
        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = image
        
        // wrap the attachment in its own attributed string so we can append it
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
        case .email: break
        }
        return firstString + secondString + imageString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeNavBarColor(.clear)
    }
    override func viewDidLayoutSubviews() {
        self.changeNavBarColor(.clear)
        super.viewDidLayoutSubviews()
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
