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
    func moveToCreateUserScreen(_ fromView: LoginViewProtocol, type: SignUpType)
  func moveToHomeScreen(_ fromView: LoginViewProtocol)
  func createLoginWithEmail(_ fromView: LoginViewProtocol)
  // PRESENTER -> WIREFRAME
}

protocol LoginPresenterProtocol: class {
  var view: LoginViewProtocol? { get set }
  var interactor: LoginInteractorInputProtocol? { get set }
  var wireFrame: LoginWireFrameProtocol? { get set }
  weak var controller: UIViewController? { get set }
  func didTapAtRegisterButton()
  func didTapAtLoginWithFacebook()
  func didTapAtLoginWithSnapChat()
  func didTapAtLoginWithEmail()
  func moveToLoginWithEmail()
  var email: String! {get set}
  var password: String! {get set}
}

protocol LoginInteractorOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func generateFetchFacebookProfile(_ value: [String: Any])
  func generateuserLogin(_ value: ServerResponseModal)
  func onError(value: String)
  // INTERACTOR -> PRESENTER
 
}

protocol LoginInteractorInputProtocol: class {
  var presenter: LoginInteractorOutputProtocol? { get set }
  var dataManager: LoginDataManagerInputProtocol? { get set }
  func generateOtpWith(_ params: [String: Any])
  func loginUser(_ params: [String: Any])
  func fetchFacebookProfile()
  // PRESENTER -> INTERACTOR
}

protocol LoginDataManagerInputProtocol: class {
  var remoteRequestHandler: LoginDataManagerOutputProtocol? { get set }
  func generateOtpWith(_ params: [String: Any])
    
    func fetchFacebookProfile()
  // INTERACTOR -> DATAMANAGER
}

protocol LoginDataManagerOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func generateFetchFacebookProfile(_ value: [String: Any])
  func onError(value: String)
  // REMOTEDATAMANAGER -> INTERACTOR
 
}

