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
    self.wireFrame?.showLoginScreen(from: self.view!)
  }
}


extension AuthTokenVerifierPresenter: AuthTokenVerifierInteractorOutputProtocol {
  
  func AppDataResponse(_ response: ServerResponseModal) {
        self.wireFrame?.showLoginScreen(from: self.view!)
  }
  
}
