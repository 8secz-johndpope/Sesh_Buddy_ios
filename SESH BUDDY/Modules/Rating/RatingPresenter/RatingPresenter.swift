//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class RatingPresenter: RatingPresenterProtocol, RatingInteractorOutputProtocol
{
    weak var view: RatingViewProtocol?
    var interactor: RatingInteractorInputProtocol?
    var wireFrame: RatingWireFrameProtocol?
    
    init() {}
}
