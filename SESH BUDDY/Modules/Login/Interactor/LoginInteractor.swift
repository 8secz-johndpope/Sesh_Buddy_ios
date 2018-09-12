//
//  LoginInteractor.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {
  var presenter: LoginInteractorOutputProtocol?
  var dataManager: LoginDataManagerInputProtocol?
  
  func generateOtpWith(_ params: [String: Any]) {
    dataManager?.generateOtpWith(params)
  }
  
}

extension LoginInteractor: LoginDataManagerOutputProtocol {
  func onError(value: String) {
    
  }
  
  func generatedOtpWith(_ value: ServerResponseModal) {
    presenter?.generatedOtpWith(value)
  }
 
}
