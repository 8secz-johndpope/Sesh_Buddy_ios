//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class HistoryPresenter: HistoryPresenterProtocol, HistoryInteractorOutputProtocol
{
    weak var view: HistoryViewProtocol?
    var interactor: HistoryInteractorInputProtocol?
    var wireFrame: HistoryWireFrameProtocol?
    
    init() {}
}
