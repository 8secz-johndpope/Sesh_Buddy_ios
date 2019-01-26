//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

protocol TopBuddyViewProtocol: class
{
    var presenter: TopBuddyPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol TopBuddyWireFrameProtocol: class
{
    static func presentTopBuddyModule()-> UIViewController
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol TopBuddyPresenterProtocol: class
{
    var view: TopBuddyViewProtocol? { get set }
    var interactor: TopBuddyInteractorInputProtocol? { get set }
    var wireFrame: TopBuddyWireFrameProtocol? { get set }
   
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol TopBuddyInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol TopBuddyInteractorInputProtocol: class
{
    var presenter: TopBuddyInteractorOutputProtocol? { get set }
    var APIDataManager: TopBuddyAPIDataManagerInputProtocol? { get set }
    var localDatamanager: TopBuddyLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}

protocol TopBuddyDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol TopBuddyAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol TopBuddyLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
