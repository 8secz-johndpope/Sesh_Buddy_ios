//
//  LoginInteractor.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation

class EditProfileInteractor: EditProfileInteractorInputProtocol {
    
  var presenter: EditProfileInteractorOutputProtocol?
  
  func generateOtpWith(_ params: [String: Any]) {
  }
  
}

extension EditProfileInteractor: EditProfileDataManagerOutputProtocol {
  func onError(value: String) {
    
  }
  
  func generatedOtpWith(_ value: ServerResponseModal) {
    presenter?.generatedOtpWith(value)
  }
 
}
