//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation
import UIKit

class RatingWireFrame: RatingWireFrameProtocol
{
   
    class func presentRatingModule() ->UIViewController
    {
        // Generating module components
        let view = RatingViewController()
        let presenter: RatingPresenterProtocol & RatingInteractorOutputProtocol = RatingPresenter()
        let interactor: RatingInteractorInputProtocol = RatingInteractor()
        let APIDataManager: RatingAPIDataManagerInputProtocol = RatingAPIDataManager()
        let localDataManager: RatingLocalDataManagerInputProtocol = RatingLocalDataManager()
        let wireFrame: RatingWireFrameProtocol = RatingWireFrame()
        
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
