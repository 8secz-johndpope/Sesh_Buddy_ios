//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class myFirstmoduleWireFrame: myFirstmoduleWireFrameProtocol
{
    class func presentmyFirstmoduleModule(fromView view: AnyObject)
    {
        // Generating module components
        var view: myFirstmoduleViewProtocol = myFirstmoduleView()
        var presenter: protocol<myFirstmodulePresenterProtocol, myFirstmoduleInteractorOutputProtocol> = myFirstmodulePresenter()
        var interactor: myFirstmoduleInteractorInputProtocol = myFirstmoduleInteractor()
        var APIDataManager: myFirstmoduleAPIDataManagerInputProtocol = myFirstmoduleAPIDataManager()
        var localDataManager: myFirstmoduleLocalDataManagerInputProtocol = myFirstmoduleLocalDataManager()
        var wireFrame: myFirstmoduleWireFrameProtocol = myFirstmoduleWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
    }
}