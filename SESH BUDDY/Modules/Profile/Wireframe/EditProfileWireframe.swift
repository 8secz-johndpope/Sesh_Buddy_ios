//
//  EditProfileWireframe.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

class EditProfileWireFrame: EditProfileWireFrameProtocol {

  static func createEditProfileModule() -> UIViewController {
      let view = ProfileViewController()
      let presenter: EditProfilePresenterProtocol & EditProfileInteractorOutputProtocol = EditProfilePresenter()
      let interactor: EditProfileInteractorInputProtocol & EditProfileDataManagerOutputProtocol = EditProfileInteractor()
      let wireFrame: EditProfileWireFrameProtocol = EditProfileWireFrame()
      view.presenter = presenter
      presenter.view = view
      presenter.wireFrame = wireFrame
      presenter.interactor = interactor
      interactor.presenter = presenter
      return view
   
  }
  
 
}
