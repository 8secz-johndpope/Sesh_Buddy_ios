//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class SessionsInteractor: SessionsInteractorInputProtocol
{
    weak var presenter: SessionsInteractorOutputProtocol?
    var APIDataManager: SessionsAPIDataManagerInputProtocol?
    var localDatamanager: SessionsLocalDataManagerInputProtocol?
    
    init() {}
}
