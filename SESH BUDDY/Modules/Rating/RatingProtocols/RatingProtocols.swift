//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation
import UIKit

protocol RatingViewProtocol: class
{
    var presenter: RatingPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol RatingWireFrameProtocol: class
{
    static func presentRatingModule() ->UIViewController
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol RatingPresenterProtocol: class
{
    var view: RatingViewProtocol? { get set }
    var interactor: RatingInteractorInputProtocol? { get set }
    var wireFrame: RatingWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol RatingInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol RatingInteractorInputProtocol: class
{
    var presenter: RatingInteractorOutputProtocol? { get set }
    var APIDataManager: RatingAPIDataManagerInputProtocol? { get set }
    var localDatamanager: RatingLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}

protocol RatingDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol RatingAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol RatingLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
