//
//  EditProfileProtocol.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

protocol EditProfileViewProtocol: class {
  var presenter: EditProfilePresenterProtocol? { get set }
  func onError(value: String)
  func showAlert(_ string: String)
  func reloadView()

}

protocol EditProfileWireFrameProtocol: class {
  static func createEditProfileModule() -> UIViewController
    
  // PRESENTER -> WIREFRAME
}

protocol EditProfilePresenterProtocol: class {
  var view: EditProfileViewProtocol? { get set }
  var interactor: EditProfileInteractorInputProtocol? { get set }
  var wireFrame: EditProfileWireFrameProtocol? { get set }
    var firstName: String! {get set}
    var lastName: String! {get set}
    var dob: String! {get set}
    var gender: Int! {get set}
    var userName: String! {get set}
    var favoritStrain: String! {get set}
    var email: String! {get set}
    var aboutMe: String {get set}
    var coverPic: String {get set}
    var profilePic: String {get set}
    func didTapAtNotifications()
    func didTapAtLogout()
    func editProfileImage(image: UIImage, type: ImageType)
    func didTapAtEditProfile()
}

protocol EditProfileInteractorOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func logoutUserWith(_ value: ServerResponseModal)
  func updateProfileImage(_ value: ServerResponseModal, type: ImageType)
  func updateProfileWith(_ value: ServerResponseModal)
  func onError(value: String)
  // INTERACTOR -> PRESENTER
 
}

protocol EditProfileInteractorInputProtocol: class {
  var presenter: EditProfileInteractorOutputProtocol? { get set }
  func generateOtpWith(_ params: [String: Any])
    func editProfileImage(image: UIImage, type: ImageType)
  func logoutFromApp()
    func editProfileWith(_ params: [String: Any])
  // PRESENTER -> INTERACTOR
}

protocol EditProfileDataManagerInputProtocol: class {
  var remoteRequestHandler: EditProfileDataManagerOutputProtocol? { get set }
  func generateOtpWith(_ params: [String: Any]) 
  // INTERACTOR -> DATAMANAGER
}

protocol EditProfileDataManagerOutputProtocol: class {
  func generatedOtpWith(_ value: ServerResponseModal)
  func onError(value: String)
  // REMOTEDATAMANAGER -> INTERACTOR
 
}

