//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class BuddyProfileWireFrame: BuddyProfileWireFrameProtocol
{
    class  func presentBuddyProfileModule()-> UIViewController {
        // Generating module components
        let view = BuddyProfileViewController()
       // var view: BuddyProfileViewProtocol = BuddyProfileView()
       let presenter: BuddyProfilePresenterProtocol & BuddyProfileInteractorOutputProtocol = BuddyProfilePresenter()
        let interactor: BuddyProfileInteractorInputProtocol = BuddyProfileInteractor()
        let APIDataManager: BuddyProfileAPIDataManagerInputProtocol = BuddyProfileAPIDataManager()
        let localDataManager: BuddyProfileLocalDataManagerInputProtocol = BuddyProfileLocalDataManager()
        let wireFrame: BuddyProfileWireFrameProtocol = BuddyProfileWireFrame()
        
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
    func moveToTopSeshBuddies(_ fromView: BuddyProfileViewProtocol) {
        let view = TopSeshBuddiesViewController()
        let presenter: TopBuddyPresenterProtocol & TopBuddyInteractorOutputProtocol = TopBuddyPresenter()
        let interactor: TopBuddyInteractorInputProtocol = TopBuddyInteractor()
        let wireFrame: TopBuddyWireFrameProtocol = TopBuddyWireFrame()
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        if let sourceView = fromView as? UIViewController {
            sourceView.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func moveToViewAllRatings(_ fromView: BuddyProfileViewProtocol) {
       let view = RatingWireFrame.presentRatingModule()
        if let sourceView = fromView as? UIViewController {
            sourceView.navigationController?.pushViewController(view, animated: true)
        }
    }
}
