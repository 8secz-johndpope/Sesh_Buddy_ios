//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class myFirstmoduleInteractor: myFirstmoduleInteractorInputProtocol
{
    weak var presenter: myFirstmoduleInteractorOutputProtocol?
    var APIDataManager: myFirstmoduleAPIDataManagerInputProtocol?
    var localDatamanager: myFirstmoduleLocalDataManagerInputProtocol?
    
    init() {}
}