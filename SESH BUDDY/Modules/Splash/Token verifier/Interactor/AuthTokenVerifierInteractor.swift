//
//  AuthTokenVerifierInteractor.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 26/04/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import Alamofire

class AuthTokenVerifierInteractor: AuthTokenVerifierInteractorInputProtocol {
  var presenter: AuthTokenVerifierInteractorOutputProtocol?
  
  func getLoginData(_ params: [String : Any]) {
   
  }
  
  func getAppData(_ params: [String : Any]) {
//    HTTPRequest.init(method: HTTPMethod.get, path: Urls.allowed_auth_channels, parameters: params, encoding: .json, files: nil)
//      .config(isIndicatorEnable: true, isAlertEnable: true)
//      .handler(httpModel: false) { (response: HTTPResponse) in
//        print(response.value ?? "No result")
//        let serverResponse = response.getServerResponseModal()
//        self.presenter?.AppDataResponse(serverResponse)
//    }
  }
  
}


