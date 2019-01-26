//
//  LoginInteractor.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import Alamofire

class LoginInteractor: LoginInteractorInputProtocol {
    
    
    var presenter: LoginInteractorOutputProtocol?
    var dataManager: LoginDataManagerInputProtocol?
    
    func generateOtpWith(_ params: [String: Any]) {
        dataManager?.generateOtpWith(params)
    }
    func fetchFacebookProfile() {
        self.dataManager?.fetchFacebookProfile()
    }
    func loginUser(_ params: [String: Any]) {
        let header = [ParametersKeys.platform : platform
        ]
        HTTPRequest.init(method: HTTPMethod.post, path: Urls.login, parameters: params, encoding: .json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: true).headers(headers: header)
            .handler(httpModel: false) { (response: HTTPResponse) in
                print(response.value ?? "No result")
                let serverResponse = response.getServerResponseModal()
                self.presenter?.generateuserLogin(serverResponse)
        }
    }
}

extension LoginInteractor: LoginDataManagerOutputProtocol {
    func generateFetchFacebookProfile(_ value: [String: Any]) {
        
    }
    
  func onError(value: String) {
    
  }
  func generatedOtpWith(_ value: ServerResponseModal) {
    presenter?.generatedOtpWith(value)
  }
 
}
