//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class BuddiesPresenter: BuddiesPresenterProtocol, BuddiesInteractorOutputProtocol
{
    weak var view: BuddiesViewProtocol?
    var interactor: BuddiesInteractorInputProtocol?
    var wireFrame: BuddiesWireFrameProtocol?
    
    init() {}
}
