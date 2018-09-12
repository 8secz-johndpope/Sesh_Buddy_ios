//
//  LoginInteractor.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation

class SettingsInteractor: SettingsInteractorInputProtocol {
    
  var presenter: SettingsInteractorOutputProtocol?
  
  func generateOtpWith(_ params: [String: Any]) {
  }
  
}

extension SettingsInteractor: SettingsDataManagerOutputProtocol {
  func onError(value: String) {
    
  }
  
  func generatedOtpWith(_ value: ServerResponseModal) {
    presenter?.generatedOtpWith(value)
  }
 
}
