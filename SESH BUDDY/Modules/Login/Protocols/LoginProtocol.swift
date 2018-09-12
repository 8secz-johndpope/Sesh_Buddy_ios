//
//  LoginProtocol.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewProtocol: class {
  var presenter: LoginPresenterProtocol? { get set }
  func onError(value: String)
  func showAlert(_ string: String)

}

protocol LoginWireFrameProtocol: class {
  static func createLoginWithOTPModule() -> UIViewController
  func moveToCreateUserScreen(_ fromView: LoginViewProtocol)
  // PRESENTER -> WIREFRAME
}

protocol LoginPresenterProtocol: class {
  var view: LoginViewProtocol? { get set }
  var interactor: LoginInteractorInputProtocol? { get set }
  var wireFrame: LoginWireFrameProtocol? { get set }
  
  func didTapAtRegisterButton()
  func didTapAtLoginWithFacebook()
  func didTapAtLoginWithSnapChat()
}

protocol LoginInteractorOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func onError(value: String)
  // INTERACTOR -> PRESENTER
 
}

protocol LoginInteractorInputProtocol: class {
  var presenter: LoginInteractorOutputProtocol? { get set }
  var dataManager: LoginDataManagerInputProtocol? { get set }
  func generateOtpWith(_ params: [String: Any]) 
  // PRESENTER -> INTERACTOR
}

protocol LoginDataManagerInputProtocol: class {
  var remoteRequestHandler: LoginDataManagerOutputProtocol? { get set }
  func generateOtpWith(_ params: [String: Any]) 
  // INTERACTOR -> DATAMANAGER
}

protocol LoginDataManagerOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func onError(value: String)
  // REMOTEDATAMANAGER -> INTERACTOR
 
}

