//
//  LoginWireframe.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

class LoginWireFrame: LoginWireFrameProtocol {
  
  class func createLoginWithOTPModule() -> UIViewController {
    //    guard let view = Storyboards.authorization.getStoryBoard().instantiateViewController(withIdentifier: String.init(describing: LoginWithOTPViewController.self)) as? LoginWithOTPViewController else {
    //      return UIViewController()
    //    }
    let navController = Storyboards.authorization.getStoryBoard().instantiateViewController(withIdentifier: String.init(describing: AuthNavigationViewController.self))
    if let view = navController.childViewControllers.first as? LoginOptionsViewController {
      let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
      let interactor: LoginInteractorInputProtocol & LoginDataManagerOutputProtocol = LoginInteractor()
      let remoteDataManager: LoginDataManagerInputProtocol = LoginDataManager()
      let wireFrame: LoginWireFrameProtocol = LoginWireFrame()
      view.presenter = presenter
      presenter.view = view
      presenter.wireFrame = wireFrame
      presenter.interactor = interactor
      interactor.presenter = presenter
      interactor.dataManager = remoteDataManager
      remoteDataManager.remoteRequestHandler = interactor
      return navController
    } else {
      return UIViewController()
    }
  }
  
  class func createLoginWithOTPModuleWithoutNav() -> UIViewController {
    if let view = Storyboards.authorization.getStoryBoard().instantiateViewController(withIdentifier: "LoginOptionsViewController") as? LoginOptionsViewController  {
      let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
      let interactor: LoginInteractorInputProtocol & LoginDataManagerOutputProtocol = LoginInteractor()
      let remoteDataManager: LoginDataManagerInputProtocol = LoginDataManager()
      let wireFrame: LoginWireFrameProtocol = LoginWireFrame()
      
      view.presenter = presenter
      presenter.view = view
      presenter.wireFrame = wireFrame
      presenter.interactor = interactor
      interactor.presenter = presenter
      interactor.dataManager = remoteDataManager
      remoteDataManager.remoteRequestHandler = interactor
      
      return view
    } else {
      return UIViewController()
    }
  }
    func moveToCreateUserScreen(_ fromView: LoginViewProtocol) {
        let createUserView = CreateUserWireFrame.createUserModule()
        if let sourceView = fromView as? UIViewController {
            sourceView.navigationController?.setNavigationBarHidden(false, animated: false)
            sourceView.navigationController?.pushViewController(createUserView, animated: true)
           }
    }
}
