//
//  AuthTokenVerifierWireframe.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 26/04/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

class AuthTokenVerifierWireFrame: AuthTokenVerifierWireFrameProtocol {
  
  class func createAuthTokenVerifierModule() -> UIViewController {
    if let navController = Storyboards.authorization.getStoryBoard().instantiateViewController(withIdentifier: String.init(describing: AuthNavigationViewController.self)) as? UINavigationController {
     let view = AuthTokenVerifierViewController()
      let presenter: AuthTokenVerifierPresenterProtocol & AuthTokenVerifierInteractorOutputProtocol = AuthTokenVerifierPresenter()
      let interactor: AuthTokenVerifierInteractorInputProtocol  = AuthTokenVerifierInteractor()
      let wireFrame: AuthTokenVerifierWireFrameProtocol = AuthTokenVerifierWireFrame()
      
      view.presenter = presenter
      presenter.view = view
      presenter.wireFrame = wireFrame
      presenter.interactor = interactor
      interactor.presenter = presenter
      
      navController.setViewControllers([view], animated: true)
      
      return navController
    }
    return UIViewController()
  }
    
    class func createSingleAuthTokenVerifierModule() -> UIViewController {
            let view = AuthTokenVerifierViewController()
            let presenter: AuthTokenVerifierPresenterProtocol & AuthTokenVerifierInteractorOutputProtocol = AuthTokenVerifierPresenter()
            let interactor: AuthTokenVerifierInteractorInputProtocol  = AuthTokenVerifierInteractor()
            let wireFrame: AuthTokenVerifierWireFrameProtocol = AuthTokenVerifierWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            
        
            return view
    }
  
  func showLoginScreen(from view: AuthTokenVerifierViewProtocol) {
    let loginVC = LoginWireFrame.createLoginWithOTPModuleWithoutNav()
    if let sourceView = view as? UIViewController {
      DispatchQueue.main.async {
        sourceView.navigationController?.setViewControllers([loginVC], animated: true)
      }
    }
  }
  
  func showRegisterScreen(from view: AuthTokenVerifierViewProtocol) {
    //    let RegisterViewController = RegisterWireFrame.createRegisterModule()
    //    if let sourceView = view as? UIViewController {
    //      sourceView.navigationController?.pushViewController(RegisterViewController, animated: true)
    //    }
  }
  
  func moveToRegister(_ fromView: AuthTokenVerifierViewProtocol) {
//    let RegisterController = RegisterWireFrame.createRegisterModule()
//    if let sourceView = fromView as? UIViewController {
//      sourceView.navigationController?.setViewControllers([RegisterController], animated: true)
//    }
  }
  
}
