//
//  SettingsWireframe.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

class SettingsWireFrame: SettingsWireFrameProtocol {

  static func createSettingsModule() -> UIViewController {
      let view = SettingsViewController()
      let presenter: SettingsPresenterProtocol & SettingsInteractorOutputProtocol = SettingsPresenter()
      let interactor: SettingsInteractorInputProtocol & SettingsDataManagerOutputProtocol = SettingsInteractor()
      let wireFrame: SettingsWireFrameProtocol = SettingsWireFrame()
      view.presenter = presenter
      presenter.view = view
      presenter.wireFrame = wireFrame
      presenter.interactor = interactor
      interactor.presenter = presenter
      return view
   
  }
  
    func moveToNavigations(fromView: SettingsViewProtocol) {
        let view = NotificationsViewController()
        let presenter: SettingsPresenterProtocol & SettingsInteractorOutputProtocol = SettingsPresenter()
        let interactor: SettingsInteractorInputProtocol & SettingsDataManagerOutputProtocol = SettingsInteractor()
        let wireFrame: SettingsWireFrameProtocol = SettingsWireFrame()
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
            if let sourceView = fromView as? UIViewController {
              sourceView.navigationController?.pushViewController(view, animated: true)
            }
    }
 
}
