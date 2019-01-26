//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class TopBuddyPresenter: TopBuddyPresenterProtocol, TopBuddyInteractorOutputProtocol
{
    weak var view: TopBuddyViewProtocol?
    var interactor: TopBuddyInteractorInputProtocol?
    var wireFrame: TopBuddyWireFrameProtocol?
    
    init() {}
    
    func moveToTopSeshBuddies() {
        
    }
}
