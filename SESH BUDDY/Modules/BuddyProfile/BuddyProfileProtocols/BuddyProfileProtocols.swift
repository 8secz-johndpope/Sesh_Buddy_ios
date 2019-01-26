//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

protocol BuddyProfileViewProtocol: class
{
    var presenter: BuddyProfilePresenterProtocol? { get set }
    func onError(value: String)
    func showAlert(_ string: String)
    func reloadView()
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol BuddyProfileWireFrameProtocol: class
{
    static func presentBuddyProfileModule()-> UIViewController
    func moveToTopSeshBuddies(_ fromView: BuddyProfileViewProtocol)
    func moveToViewAllRatings(_ fromView: BuddyProfileViewProtocol)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol BuddyProfilePresenterProtocol: class
{
    var view: BuddyProfileViewProtocol? { get set }
    var interactor: BuddyProfileInteractorInputProtocol? { get set }
    var wireFrame: BuddyProfileWireFrameProtocol? { get set }
    var coverPic: String! { get set }
    var profilePic: String! { get set }
    var aboutMe: String! { get set }
    func updatePictureClick(image: UIImage, type: ImageType)
     func moveToTopSeshBuddies()
    func moveToViewAllRatings()
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol BuddyProfileInteractorOutputProtocol: class
{
    func updateProfileImage(_ value: ServerResponseModal, type: ImageType)
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol BuddyProfileInteractorInputProtocol: class
{
    var presenter: BuddyProfileInteractorOutputProtocol? { get set }
    var APIDataManager: BuddyProfileAPIDataManagerInputProtocol? { get set }
    var localDatamanager: BuddyProfileLocalDataManagerInputProtocol? { get set }
     func editProfileImage(image: UIImage, type: ImageType)
    
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}

protocol BuddyProfileDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol BuddyProfileAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
}

protocol BuddyProfileLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
}
