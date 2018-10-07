//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation
import UIKit

class HistoryWireFrame: HistoryWireFrameProtocol
{
    class func presentHistoryModule() -> UIViewController {
        // Generating module components
        let view = HistoryViewController()
        let presenter: HistoryPresenterProtocol & HistoryInteractorOutputProtocol = HistoryPresenter()
        let interactor: HistoryInteractorInputProtocol = HistoryInteractor()
        let APIDataManager: HistoryAPIDataManagerInputProtocol = HistoryAPIDataManager()
        let localDataManager: HistoryLocalDataManagerInputProtocol = HistoryLocalDataManager()
        let wireFrame: HistoryWireFrameProtocol = HistoryWireFrame()
        
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
