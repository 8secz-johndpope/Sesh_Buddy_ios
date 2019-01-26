//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class TopBuddyInteractor: TopBuddyInteractorInputProtocol
{
    weak var presenter: TopBuddyInteractorOutputProtocol?
    var APIDataManager: TopBuddyAPIDataManagerInputProtocol?
    var localDatamanager: TopBuddyLocalDataManagerInputProtocol?
    
    init() {}
}
