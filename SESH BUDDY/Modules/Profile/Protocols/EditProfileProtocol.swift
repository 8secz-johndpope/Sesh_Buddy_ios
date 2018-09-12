//
//  EditProfileProtocol.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

protocol EditProfileViewProtocol: class {
  var presenter: EditProfilePresenterProtocol? { get set }
  func onError(value: String)
  func showAlert(_ string: String)

}

protocol EditProfileWireFrameProtocol: class {
  static func createEditProfileModule() -> UIViewController
    
  // PRESENTER -> WIREFRAME
}

protocol EditProfilePresenterProtocol: class {
  var view: EditProfileViewProtocol? { get set }
  var interactor: EditProfileInteractorInputProtocol? { get set }
  var wireFrame: EditProfileWireFrameProtocol? { get set }
    
    func didTapAtNotifications()
}

protocol EditProfileInteractorOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func onError(value: String)
  // INTERACTOR -> PRESENTER
 
}

protocol EditProfileInteractorInputProtocol: class {
  var presenter: EditProfileInteractorOutputProtocol? { get set }
  func generateOtpWith(_ params: [String: Any]) 
  // PRESENTER -> INTERACTOR
}

protocol EditProfileDataManagerInputProtocol: class {
  var remoteRequestHandler: EditProfileDataManagerOutputProtocol? { get set }
  func generateOtpWith(_ params: [String: Any]) 
  // INTERACTOR -> DATAMANAGER
}

protocol EditProfileDataManagerOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func onError(value: String)
  // REMOTEDATAMANAGER -> INTERACTOR
 
}

