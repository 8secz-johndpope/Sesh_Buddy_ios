//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class myFirstmodulePresenter: myFirstmodulePresenterProtocol, myFirstmoduleInteractorOutputProtocol
{
    weak var view: myFirstmoduleViewProtocol?
    var interactor: myFirstmoduleInteractorInputProtocol?
    var wireFrame: myFirstmoduleWireFrameProtocol?
    
    init() {}
}