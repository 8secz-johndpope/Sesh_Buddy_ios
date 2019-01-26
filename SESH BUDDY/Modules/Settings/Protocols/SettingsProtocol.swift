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
    func reloadView(_ with: NotificationSetting)

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
    var isSHMOKeEnabled: Bool! {get set}
    var isMATCHEnabled: Bool! {get set}
    var isDROPEnabled: Bool! {get set}
    var isSMOEnabled: Bool! {get set}
    var isDEALSEnabled: Bool! {get set}
    var isSMOIOUEnabled: Bool! {get set}
    func getNotificationSetting()
    func didTapAtNotifications()
    func updateNotificationSettings()
}

protocol SettingsInteractorOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func getNotificationSetting(_ value: ServerResponseModal)
  func onError(value: String)
  // INTERACTOR -> PRESENTER
 
}

protocol SettingsInteractorInputProtocol: class {
  var presenter: SettingsInteractorOutputProtocol? { get set }
  func generateOtpWith(_ params: [String: Any])
  func updateNotificationSettings(_ params: [String: Any])
  func getNotificationSetting()
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

