//
//  AuthTokenVerifierPresenter.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 26/04/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

class AuthTokenVerifierPresenter: AuthTokenVerifierPresenterProtocol {
  
  weak var view: AuthTokenVerifierViewProtocol?
  var interactor: AuthTokenVerifierInteractorInputProtocol?
  var wireFrame: AuthTokenVerifierWireFrameProtocol?
    var loginParamDict = [String: Any]()
  
  func viewDidLoad() {
    
    if KeyChain.getAccessToken() != nil {
        self.getAppData()
        guard ApplicationData.shared.checkLoginData(), ApplicationData.shared.getLoginData().userName != nil, !ApplicationData.shared.getLoginData().userName.isEmpty else {
            self.wireFrame?.moveToCreateUser(self.view!)
            return
        }
        self.wireFrame?.moveToHomeScreen(self.view!)
     } else {
        self.wireFrame?.showLoginScreen(from: self.view!)
     }
  }
    func getAppData(){
        if let loginData = UserDefaults.standard.value(forKey: keyLoginData) as? [String: Any] {
            ApplicationData.shared.setLoginData(Login(fromDictionary: loginData))
        }
    }
}


extension AuthTokenVerifierPresenter: AuthTokenVerifierInteractorOutputProtocol {
  
  func AppDataResponse(_ response: ServerResponseModal) {
        self.wireFrame?.showLoginScreen(from: self.view!)
  }
  
}
