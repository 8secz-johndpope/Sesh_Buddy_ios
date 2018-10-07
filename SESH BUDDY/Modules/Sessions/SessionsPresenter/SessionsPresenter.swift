//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class SessionsPresenter: SessionsPresenterProtocol, SessionsInteractorOutputProtocol
{
    weak var view: SessionsViewProtocol?
    var interactor: SessionsInteractorInputProtocol?
    var wireFrame: SessionsWireFrameProtocol?
    
    init() {}
}
