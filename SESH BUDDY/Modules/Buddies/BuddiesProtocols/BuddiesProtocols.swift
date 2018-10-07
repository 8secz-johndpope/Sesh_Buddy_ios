//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation
import UIKit

protocol BuddiesViewProtocol: class
{
    var presenter: BuddiesPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol BuddiesWireFrameProtocol: class
{
    static func presentBuddiesModule() ->UIViewController
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol BuddiesPresenterProtocol: class
{
    var view: BuddiesViewProtocol? { get set }
    var interactor: BuddiesInteractorInputProtocol? { get set }
    var wireFrame: BuddiesWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol BuddiesInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol BuddiesInteractorInputProtocol: class
{
    var presenter: BuddiesInteractorOutputProtocol? { get set }
    var APIDataManager: BuddiesAPIDataManagerInputProtocol? { get set }
    var localDatamanager: BuddiesLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}

protocol BuddiesDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol BuddiesAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol BuddiesLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
