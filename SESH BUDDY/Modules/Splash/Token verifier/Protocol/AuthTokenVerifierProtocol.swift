//
//  AuthTokenVerifierProtocol.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 26/04/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

protocol AuthTokenVerifierViewProtocol: class {
  var presenter: AuthTokenVerifierPresenterProtocol? { get set }
  // PRESENTER -> VIEW
  func showAlert(_ string: String) 
    
}

protocol AuthTokenVerifierWireFrameProtocol: class {
  static func createAuthTokenVerifierModule() -> UIViewController
  func moveToCreateUser(_ fromView: AuthTokenVerifierViewProtocol)
  static func createSingleAuthTokenVerifierModule() -> UIViewController
  func showLoginScreen(from view: AuthTokenVerifierViewProtocol)
  func moveToHomeScreen(_ fromView: AuthTokenVerifierViewProtocol)
  // PRESENTER -> WIREFRAME
}

protocol AuthTokenVerifierPresenterProtocol: class {
  var view: AuthTokenVerifierViewProtocol? { get set }
  var interactor: AuthTokenVerifierInteractorInputProtocol? { get set }
  var wireFrame: AuthTokenVerifierWireFrameProtocol? { get set }
  
  func viewDidLoad()
  
}

protocol AuthTokenVerifierInteractorOutputProtocol: class {
  // INTERACTOR -> PRESENTER
  
  func AppDataResponse(_ response: ServerResponseModal)

}

protocol AuthTokenVerifierInteractorInputProtocol: class {
  var presenter: AuthTokenVerifierInteractorOutputProtocol? { get set }
  func getLoginData(_ params: [String: Any])
  func getAppData(_ params: [String: Any])

  // PRESENTER -> INTERACTOR
}



