//
//  LoginDataManager.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import Alamofire

class LoginDataManager:LoginDataManagerInputProtocol {
    func fetchFacebookProfile() {
        
    }
    
  var remoteRequestHandler: LoginDataManagerOutputProtocol?
  
  func generateOtpWith(_ params: [String: Any]) {
//    AuthManager.shared.generateOtpWith(params) { (serverResponse) in
//      self.remoteRequestHandler?.generatedOtpWith(serverResponse)
//    }
  }
  
  
}
