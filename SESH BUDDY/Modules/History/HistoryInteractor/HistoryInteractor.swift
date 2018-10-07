//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class HistoryInteractor: HistoryInteractorInputProtocol {
    weak var presenter: HistoryInteractorOutputProtocol?
    var APIDataManager: HistoryAPIDataManagerInputProtocol?
    var localDatamanager: HistoryLocalDataManagerInputProtocol?
    
    init() {}
}
