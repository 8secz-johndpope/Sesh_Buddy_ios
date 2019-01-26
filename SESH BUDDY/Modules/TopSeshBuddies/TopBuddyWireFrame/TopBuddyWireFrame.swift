//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class TopBuddyWireFrame: TopBuddyWireFrameProtocol
{
    class func presentTopBuddyModule()-> UIViewController
    {
        // Generating module components
        let view = TopSeshBuddiesViewController()
        // var view: BuddyProfileViewProtocol = BuddyProfileView()
        let presenter: TopBuddyPresenterProtocol & TopBuddyInteractorOutputProtocol = TopBuddyPresenter()
        let interactor: TopBuddyInteractorInputProtocol = TopBuddyInteractor()
        let APIDataManager: TopBuddyAPIDataManagerInputProtocol = TopBuddyAPIDataManager()
        let localDataManager: TopBuddyLocalDataManagerInputProtocol = TopBuddyLocalDataManager()
        let wireFrame: TopBuddyWireFrameProtocol = TopBuddyWireFrame()
        
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
