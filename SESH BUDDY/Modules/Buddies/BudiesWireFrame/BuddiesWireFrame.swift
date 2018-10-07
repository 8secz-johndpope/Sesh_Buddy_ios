//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation
import UIKit

class BuddiesWireFrame: BuddiesWireFrameProtocol
{
    class func presentBuddiesModule() ->UIViewController
    {
        // Generating module components
        let view = BuddiesViewController()
        let presenter: BuddiesPresenterProtocol & BuddiesInteractorOutputProtocol = BuddiesPresenter()
        let interactor: BuddiesInteractorInputProtocol = BuddiesInteractor()
        let APIDataManager: BuddiesAPIDataManagerInputProtocol = BuddiesAPIDataManager()
        let localDataManager: BuddiesLocalDataManagerInputProtocol = BuddiesLocalDataManager()
        let wireFrame: BuddiesWireFrameProtocol = BuddiesWireFrame()
        
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
