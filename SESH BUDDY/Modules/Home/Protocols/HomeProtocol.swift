//
//  SettingsProtocol.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewProtocol: class {
  var presenter: HomePresenterProtocol? { get set }
  func onError(value: String)
  func showAlert(_ string: String)

}

protocol HomeWireFrameProtocol: class {
  static func createSettingsModule() -> UIViewController
    
  // PRESENTER -> WIREFRAME
}

protocol HomePresenterProtocol: class {
  var view: HomeViewProtocol? { get set }
  var interactor: HomeInteractorInputProtocol? { get set }
  var wireFrame: HomeWireFrameProtocol? { get set }
    
    func didTapAtNotifications()
}

protocol HomeInteractorOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func onError(value: String)
  // INTERACTOR -> PRESENTER
 
}

protocol HomeInteractorInputProtocol: class {
  var presenter: HomeInteractorOutputProtocol? { get set }
//  func generateOtpWith(_ params: [String: Any])
  // PRESENTER -> INTERACTOR
}

protocol HomeDataManagerInputProtocol: class {
  var remoteRequestHandler: HomeDataManagerOutputProtocol? { get set }
//  func generateOtpWith(_ params: [String: Any]) 
  // INTERACTOR -> DATAMANAGER
}

protocol HomeDataManagerOutputProtocol: class {
//  func generatedOtpWith(_ value: ServerResponseModal)
  func onError(value: String)
  // REMOTEDATAMANAGER -> INTERACTOR
 
}

