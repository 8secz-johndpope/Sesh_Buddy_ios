//
//  EditProfilePresenter.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

class EditProfilePresenter: EditProfilePresenterProtocol {
    var coverPic: String = ""
    
    var profilePic: String = ""
    
    var aboutMe: String = ""
    var firstName: String!
    var lastName: String!
    var dob: String!
    var gender: Int!
    var userName: String!
    var favoritStrain: String!
    var email: String!
    
    
    
  weak var view: EditProfileViewProtocol?
  var interactor: EditProfileInteractorInputProtocol?
  var wireFrame: EditProfileWireFrameProtocol?
  private var phoneNumber: String!
  private var countryCode: String!
    
    func didTapAtNotifications() {
    }
    func didTapAtLogout() {
        self.interactor?.logoutFromApp()
    }
    func editProfileImage(image: UIImage, type: ImageType) {
        self.interactor?.editProfileImage(image: image, type: type)
    }
    func didTapAtEditProfile() {
        guard self.firstName != nil, !self.firstName.isEmpty else {
            self.view?.showAlert("Please enter first name.")
            return
        }
        guard self.lastName != nil, !self.lastName.isEmpty else {
            self.view?.showAlert("Please enter last name.")
            return
        }
        guard self.dob != nil, !self.dob.isEmpty else {
            self.view?.showAlert("Please select date of birth.")
            return
        }
      
        guard self.gender != nil  else {
            self.view?.showAlert("Please select gender.")
            return
        }
        guard  !self.aboutMe.isEmpty else {
            self.view?.showAlert("Please write something about you.")
            return
        }
        guard self.userName != nil, !self.userName.isEmpty else {
            self.view?.showAlert("Please enter user name.")
            return
        }
        guard self.favoritStrain != nil, !self.favoritStrain.isEmpty else {
            self.view?.showAlert("Please enter favorit strain.")
            return
        }
        let param = [ParametersKeys.firstName: self.firstName!,
                     ParametersKeys.lastName: self.lastName!,
                     ParametersKeys.dob: self.dob!,
                     ParametersKeys.gender: self.gender!,
                     ParametersKeys.userName: self.userName!,
                     ParametersKeys.coverPic: self.coverPic,
                     ParametersKeys.profilePic: self.profilePic,
                     ParametersKeys.aboutMe: self.aboutMe,
                     ParametersKeys.favoriteStrain: self.favoritStrain
                     ] as [String : Any]
        self.interactor?.editProfileWith(param)
    }
}

extension EditProfilePresenter: EditProfileInteractorOutputProtocol {
    func updateProfileImage(_ value: ServerResponseModal, type: ImageType) {
        guard let data = value.data, let status = value.status else {
            if let message = value.message {
                self.view?.showAlert(message)
            } else {
                if value.error.count > 0 {
                    let message = value.error[0]
                    self.view?.showAlert(message)
                }
            }
            return
        }
        
        if status == RESPONSE_STATUS.success {
            let loginData = Login(fromDictionary: value.data as! [String : Any] )
            var previouseLoginData = ApplicationData.shared.getLoginData()
            previouseLoginData.profilePic = loginData.profilePic
            previouseLoginData.coverPic = loginData.coverPic
            ApplicationData.shared.setLoginData(previouseLoginData)
            self.view?.reloadView()
        } else {
            if value.error != nil, value.error.count > 0 {
                let message = value.error[0]
                self.view?.showAlert(message)
            }
        }
    }
    func updateProfileWith(_ value: ServerResponseModal) {
        guard let data = value.data, let status = value.status else {
            if let message = value.message {
                self.view?.showAlert(message)
            } else {
                if value.error.count > 0 {
                    let message = value.error[0]
                    self.view?.showAlert(message)
                }
            }
            return
        }
        
        if status == RESPONSE_STATUS.success {
            let loginData = Login(fromDictionary: value.data as! [String : Any] )
            ApplicationData.shared.setLoginData(loginData)
            self.view?.reloadView()
        } else {
            if value.error != nil, value.error.count > 0 {
                let message = value.error[0]
                self.view?.showAlert(message)
            }
        }
    }
  func onError(value: String) {
    self.view?.showAlert(value)
  }
    func logoutUserWith(_ value: ServerResponseModal) {
        guard let data = value.data, let status = value.status else {
                    if let message = value.message {
                      self.view?.showAlert(message)
                    } else {
                      if value.error.count > 0 {
                        let message = value.error[0]
                        self.view?.showAlert(message)
                      }
                    }
            
                    return
        }
        
        if status == RESPONSE_STATUS.success {
            ApplicationData.shared.removeAllData()
        } else {
            if value.error != nil, value.error.count > 0 {
                let message = value.error[0]
                self.view?.showAlert(message)
            }
        }
    }
  func generatedOtpWith(_ value: ServerResponseModal) {
    
//      guard let data = value.response, let flag = value.flag  else {
//
//        if let message = value.message {
//          self.view?.showAlert(message)
//        } else {
//          if let message = value.error {
//            self.view?.showAlert(message)
//          }
//        }
//
//        return
//      }
//
//      switch flag {
//      case let x where x == RESPONSE_FLAGS.flag_143 || x == RESPONSE_FLAGS.VERIFICATION_REQUIRED:
//        var otpdata = OTPData.init(fromDictionary: data)
//        otpdata.addPhone(phoneNumber)
//        otpdata.addCountryCode(countryCode)
//        wireFrame?.showVerificationScreen(from: view!, with: otpdata)
//      default:
//        if let message = value.message {
//          self.view?.showAlert(message)
//        } else {
//          if let message = value.error {
//            self.view?.showAlert(message)
//          }
//        }
//      }
    }
  
  }
    
    

