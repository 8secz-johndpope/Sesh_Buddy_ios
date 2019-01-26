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
import SCSDKLoginKit

class LoginPresenter: LoginPresenterProtocol {
  var email: String!
  var password: String!
  var controller: UIViewController?
  weak var view: LoginViewProtocol?
  var interactor: LoginInteractorInputProtocol?
  var wireFrame: LoginWireFrameProtocol?
  private var phoneNumber: String!
  private var countryCode: String!
    var loginType: SignUpType!
  
  func didTapAtRegisterButton() {
//    self.wireFrame?.showRegistrationScreen(from: self.view!, phoneNumber: self.phoneNumber , countryCode: self.countryCode)
    self.wireFrame?.moveToCreateUserScreen(self.view!, type: .signUP)
  }
    
    func didTapAtLoginWithFacebook() {
        loginType = .facebook
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
                            var wasEmailFound = false
                            var wasUserNameFound = false
                            var userFBDetail = [String: Any]()
                            if let userDetailInfo = result as? [String: Any] {
                                var emailString = ""
                                if let fb_id = userDetailInfo["id"] as? String {
                                    userFBDetail["fb_id"] = "\(fb_id)"
                                    if let email = userDetailInfo["email"] as? String {
                                        wasEmailFound = true
                                        emailString = email
                                    } else if let username = userDetailInfo["username"] as? String {
                                        wasUserNameFound = true
                                        emailString = username + "@facebook.com"
                                    } else {
                                        emailString = "\(fb_id)" + "@facebook.com"
                                    }
                                    let facebookCoverURL = "https://graph.facebook.com/" + fb_id + "/cover?type=large"
                                    let facebookProfileUrl = "http://graph.facebook.com/\(fb_id)/picture?type=large"
                                    userFBDetail["image"] = facebookProfileUrl
                                    userFBDetail["coverImage"] = facebookCoverURL
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
                                    wasUserNameFound = true
                                    userFBDetail["username"] = username
                                }
                                if let fb_name = userDetailInfo["name"] as? String {
                                    userFBDetail["fb_name"] = fb_name
                                }
                                UserDefaults.standard.set(userFBDetail, forKey: kFBDetailInfo)
                                
                                if !wasEmailFound {
                                    self.view?.showAlert("Please add email id to your facebook account")
                                }  else {
                                    let params = [ParametersKeys.firstName: userFBDetail["first_name"]!,
                                                  ParametersKeys.lastName: userFBDetail["last_name"]!,
                                                  ParametersKeys.userName: "",
                                                  ParametersKeys.coverPic: userFBDetail["coverImage"]!,
                                                  ParametersKeys.profilePic: userFBDetail["image"]!,
                                                  ParametersKeys.loginType: LoginType.facebook.rawValue,
                                                  ParametersKeys.fcmToken: fcmToken,
                                                  ParametersKeys.email:userFBDetail["email"]!
                                    ] 
                                    self.interactor?.loginUser(params)
                                }
                                
                            }
                        }
                    })
                }
            }
        })
    }
    func didTapAtLoginWithSnapChat() {
        loginType = .snapchat
        SCSDKLoginClient.login(from: self.controller!) { (success : Bool, error : Error?) in
            let graphQLQuery = "{me{displayName, bitmoji{avatar}}}"
            SCSDKLoginClient
                .fetchUserData(
                    withQuery: graphQLQuery,
                    variables: nil,
                    success: { userInfo in
                        print(userInfo)
                }) { (error, isUserLoggedOut) in
                    print(error?.localizedDescription ?? "")
            }
        }
        
        
        
        //self.wireFrame?.moveToCreateUserScreen(self.view!, type: .snapchat)
    }
//    func fetchSnapUserInfo(){
//        let graphQLQuery = "{me{displayName, bitmoji{avatar}}}"
//        SCSDKLoginClient
//            .fetchUserData(
//                withQuery: graphQLQuery,
//                variables: nil,
//                success: { userInfo in
//                    if let userInfo = userInfo,
//                        let data = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted),
//                        let userEntity = try? JSONDecoder().decode(UserEntity.self, from: data) {
//                        DispatchQueue.main.async {
//                            self.goToLoginConfirm(userEntity)
//                        }
//                    }
//            }) { (error, isUserLoggedOut) in
//                print(error?.localizedDescription ?? "")
//        }
//    }
    func didTapAtLoginWithEmail() {
        loginType = .email
        guard self.email != nil, !self.email.isEmpty, Regex.email.validate(self.email!) else {
            self.view?.showAlert("Please enter correct email")
            return
        }
        guard self.password != nil, !self.password.isEmpty, Regex.password.validatePassword(self.password!) else {
            self.view?.showAlert("Please enter correct password")
            return
        }
        
        let params = [ParametersKeys.email: self.email!,
                      ParametersKeys.password: self.password!,
                      ParametersKeys.loginType: LoginType.signupOrLoginWithEmail.rawValue,
                      ParametersKeys.fcmToken: fcmToken
            ] as [String : Any]
        self.interactor?.loginUser(params)
    }
    func moveToLoginWithEmail() {
        self.wireFrame?.createLoginWithEmail(self.view!)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func generateuserLogin(_ value: ServerResponseModal) {
        
        if value.status != nil {
            if value.status == RESPONSE_STATUS.success {
                let loginData = Login(fromDictionary: value.data as! [String : Any] )
                ApplicationData.shared.setLoginData(loginData)
                if loginData.userName != nil, !loginData.userName.isEmpty {
                    self.wireFrame?.moveToHomeScreen(self.view!)
                } else {
                    self.wireFrame?.moveToCreateUserScreen(self.view!, type: loginType)
                }
            } else if value.error.count > 0 {
                self.view?.showAlert(value.error.first!)
            }
        } else {
        }
    }
    
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
    
    

