//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

protocol myFirstmoduleViewProtocol: class
{
    var presenter: myFirstmodulePresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol myFirstmoduleWireFrameProtocol: class
{
    class func presentmyFirstmoduleModule(fromView view: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol myFirstmodulePresenterProtocol: class
{
    var view: myFirstmoduleViewProtocol? { get set }
    var interactor: myFirstmoduleInteractorInputProtocol? { get set }
    var wireFrame: myFirstmoduleWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol myFirstmoduleInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol myFirstmoduleInteractorInputProtocol: class
{
    var presenter: myFirstmoduleInteractorOutputProtocol? { get set }
    var APIDataManager: myFirstmoduleAPIDataManagerInputProtocol? { get set }
    var localDatamanager: myFirstmoduleLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}

protocol myFirstmoduleDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol myFirstmoduleAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol myFirstmoduleLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
