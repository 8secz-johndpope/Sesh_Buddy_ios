//
//  LoginPresenter.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit
import RMessage
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class LoginPresenter: LoginPresenterProtocol {
   
    
  
  weak var view: LoginViewProtocol?
    weak var controller: UIViewController!
  var interactor: LoginInteractorInputProtocol?
  var wireFrame: LoginWireFrameProtocol?
  private var phoneNumber: String!
  private var countryCode: String!
  
  func didTapAtRegisterButton() {
//    self.wireFrame?.showRegistrationScreen(from: self.view!, phoneNumber: self.phoneNumber , countryCode: self.countryCode)
    self.wireFrame?.moveToCreateUserScreen(self.view!, type: .email)
  }
    
    func didTapAtLoginWithFacebook() {
      // CLProgressHUD.present(animated: true)
//        self.interactor?.fetchFacebookProfile()
        
        


        let loginUsingFacebook = FBSDKLoginManager()
        loginUsingFacebook.loginBehavior = .systemAccount
        loginUsingFacebook.logIn(withReadPermissions: ["public_profile", "email"], from: self.controller, handler: { (result, error) in
          //  CLProgressHUD.dismiss(animated: true)
            if error != nil {
                NSLog("Process error")
            } else if result?.isCancelled == true {
                NSLog("Canceled")
            } else if result != nil {

                let accessTokenString = Common.share.getValideString(from: result!.token.tokenString)//CommonFunctions.shareCommonMethods().passValidString(result!.token.tokenString)

                if accessTokenString.count > 0  {
                    CLProgressHUD.present(animated: true)
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) in
                        CLProgressHUD.dismiss(animated: true)
                        if error != nil {
                            CLProgressHUD.dismiss(animated: true)
                        } else {
                            var userFBDetail = [String: Any]()
                            if let userDetailInfo = result as? [String: Any] {
                                var emailString = ""
                                if let fb_id = userDetailInfo["id"] as? String {
                                    userFBDetail["fb_id"] = "\(fb_id)"

                                    if let email = userDetailInfo["email"] as? String {
                                        emailString = email
                                    } else if let username = userDetailInfo["username"] as? String {
                                        emailString = username + "@facebook.com"
                                    } else {
                                        emailString = "\(fb_id)" + "@facebook.com"
                                    }
                                    let facebookProfileUrl = "http://graph.facebook.com/\(fb_id)/picture?type=large"
                                    userFBDetail["image"] = facebookProfileUrl
                                }
                                userFBDetail["email"] = emailString
                                userFBDetail["fb_access_token"] = accessTokenString

                                if let first_name = userDetailInfo["first_name"] as? String {
                                    userFBDetail["first_name"] = first_name
                                } else {
                                    userFBDetail["first_name"] = ""
                                }

                                if let last_name = userDetailInfo["last_name"] as? String {
                                    userFBDetail["last_name"] = last_name
                                } else {
                                    userFBDetail["last_name"] = ""
                                }

                                if let username = userDetailInfo["name"] as? String {
                                    userFBDetail["username"] = username
                                }
                                if let fb_name = userDetailInfo["name"] as? String {
                                    userFBDetail["fb_name"] = fb_name
                                }
                                UserDefaults.standard.set(userFBDetail, forKey: kFBDetailInfo)
                                self.wireFrame?.moveToCreateUserScreen(self.view!, type: .facebook)
                            }
                        }
                    })
                }
            }
        })
    

        
    }
    func didTapAtLoginWithSnapChat() {
        self.wireFrame?.moveToCreateUserScreen(self.view!, type: .snapchat)
    }
    func didTapAtLoginWithEmail() {
        self.wireFrame?.moveToHomeScreen(self.view!)
    }
    func moveToLoginWithEmail() {
        self.wireFrame?.createLoginWithEmail(self.view!)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func generateFetchFacebookProfile(_ value: [String: Any]) {
        
    }
    
  func onError(value: String) {
    
  }
  
  func generatedOtpWith(_ value: ServerResponseModal) {
    
//      guard let data = value.response, let flag = value.flag  else {
//
//        if let message = value.message {
//          self.view?.showAlert(message)
//        } else {
//          if let message = value.error {
//            self.view?.showAlert(message)
//          }
//        }
//
//        return
//      }
//
//      switch flag {
//      case let x where x == RESPONSE_FLAGS.flag_143 || x == RESPONSE_FLAGS.VERIFICATION_REQUIRED:
//        var otpdata = OTPData.init(fromDictionary: data)
//        otpdata.addPhone(phoneNumber)
//        otpdata.addCountryCode(countryCode)
//        wireFrame?.showVerificationScreen(from: view!, with: otpdata)
//      default:
//        if let message = value.message {
//          self.view?.showAlert(message)
//        } else {
//          if let message = value.error {
//            self.view?.showAlert(message)
//          }
//        }
//      }
    }
  
  }
    
    

