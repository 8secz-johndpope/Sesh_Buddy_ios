//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class RatingInteractor: RatingInteractorInputProtocol
{
    weak var presenter: RatingInteractorOutputProtocol?
    var APIDataManager: RatingAPIDataManagerInputProtocol?
    var localDatamanager: RatingLocalDataManagerInputProtocol?
    
    init() {}
}
