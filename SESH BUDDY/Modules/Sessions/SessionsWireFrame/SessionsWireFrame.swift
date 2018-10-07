//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation
import UIKit

class SessionsWireFrame: SessionsWireFrameProtocol
{
    class func presentSessionsModule() -> UIViewController {
        // Generating module components
        let view = SessionsViewController()
        let presenter: SessionsPresenterProtocol & SessionsInteractorOutputProtocol = SessionsPresenter()
        let interactor: SessionsInteractorInputProtocol = SessionsInteractor()
        let APIDataManager: SessionsAPIDataManagerInputProtocol = SessionsAPIDataManager()
        let localDataManager: SessionsLocalDataManagerInputProtocol = SessionsLocalDataManager()
        let wireFrame: SessionsWireFrameProtocol = SessionsWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        return view
    }
}
