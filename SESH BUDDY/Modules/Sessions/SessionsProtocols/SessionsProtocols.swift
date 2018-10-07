//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation
import UIKit

protocol SessionsViewProtocol: class
{
    var presenter: SessionsPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol SessionsWireFrameProtocol: class
{
    static func presentSessionsModule() -> UIViewController
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol SessionsPresenterProtocol: class
{
    var view: SessionsViewProtocol? { get set }
    var interactor: SessionsInteractorInputProtocol? { get set }
    var wireFrame: SessionsWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol SessionsInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol SessionsInteractorInputProtocol: class
{
    var presenter: SessionsInteractorOutputProtocol? { get set }
    var APIDataManager: SessionsAPIDataManagerInputProtocol? { get set }
    var localDatamanager: SessionsLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}

protocol SessionsDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol SessionsAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol SessionsLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
