//
//  CreateUserWireFrame.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 06/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation
import UIKit
class CreateUserWireFrame: CreateUserWireFrameProtocol {
    static func createUserModule() -> UIViewController {
        let view = CreateUserViewController()
            let presenter: CreateUserPresenterProtocol & CreateUserInteractorOutputProtocol = CreateUserPresenter()
            let interactor: CreateUserInteractorInputProtocol  = CreateUserInteracter()
            let wireFrame: CreateUserWireFrameProtocol = CreateUserWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
        
            return view
    }
    
    func moveToHomeScreen(_ fromView: CreateUserViewProtocol) {
        appDelegate.changeVisibleRootController(Storyboards.homeFlow.getHomeScreen())
    }
    
    
}
