//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class BuddiesInteractor: BuddiesInteractorInputProtocol
{
    weak var presenter: BuddiesInteractorOutputProtocol?
    var APIDataManager: BuddiesAPIDataManagerInputProtocol?
    var localDatamanager: BuddiesLocalDataManagerInputProtocol?
    
    init() {}
}
