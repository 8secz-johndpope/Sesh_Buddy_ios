//
//  LoginPresenter.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

class LoginPresenter: LoginPresenterProtocol {
   
    
  
  weak var view: LoginViewProtocol?
  var interactor: LoginInteractorInputProtocol?
  var wireFrame: LoginWireFrameProtocol?
  private var phoneNumber: String!
  private var countryCode: String!
  
  func didTapAtRegisterButton() {
//    self.wireFrame?.showRegistrationScreen(from: self.view!, phoneNumber: self.phoneNumber , countryCode: self.countryCode)
    self.wireFrame?.moveToCreateUserScreen(self.view!)
  }
    
    func didTapAtLoginWithFacebook() {
        self.wireFrame?.moveToCreateUserScreen(self.view!)
    }
    func didTapAtLoginWithSnapChat() {
        self.wireFrame?.moveToCreateUserScreen(self.view!)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
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
    
    

