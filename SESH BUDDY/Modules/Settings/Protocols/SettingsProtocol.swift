//
//  SettingsProtocol.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewProtocol: class {
  var presenter: SettingsPresenterProtocol? { get set }
  func onError(value: String)
  func showAlert(_ string: String)

}

protocol SettingsWireFrameProtocol: class {
  static func createSettingsModule() -> UIViewController
  func moveToNavigations(fromView: SettingsViewProtocol)
    
  // PRESENTER -> WIREFRAME
}

protocol SettingsPresenterProtocol: class {
  var view: SettingsViewProtocol? { get set }
  var interactor: SettingsInteractorInputProtocol? { get set }
  var wireFrame: SettingsWireFrameProtocol? { get set }
    
    func didTapAtNotifications()
}

protocol SettingsInteractorOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func onError(value: String)
  // INTERACTOR -> PRESENTER
 
}

protocol SettingsInteractorInputProtocol: class {
  var presenter: SettingsInteractorOutputProtocol? { get set }
  func generateOtpWith(_ params: [String: Any]) 
  // PRESENTER -> INTERACTOR
}

protocol SettingsDataManagerInputProtocol: class {
  var remoteRequestHandler: SettingsDataManagerOutputProtocol? { get set }
  func generateOtpWith(_ params: [String: Any]) 
  // INTERACTOR -> DATAMANAGER
}

protocol SettingsDataManagerOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func onError(value: String)
  // REMOTEDATAMANAGER -> INTERACTOR
 
}

