//
//  SettingsPresenter.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

class SettingsPresenter: SettingsPresenterProtocol {
    var isSHMOKeEnabled: Bool! = false
    var isMATCHEnabled: Bool! = false
    var isDROPEnabled: Bool! = false
    var isSMOEnabled: Bool! = false
    var isDEALSEnabled: Bool! = false
    var isSMOIOUEnabled: Bool! = false
    
  weak var view: SettingsViewProtocol?
  var interactor: SettingsInteractorInputProtocol?
  var wireFrame: SettingsWireFrameProtocol?
  private var phoneNumber: String!
  private var countryCode: String!
    
    func didTapAtNotifications() {
        self.wireFrame?.moveToNavigations(fromView: self.view!)
    }
    func updateNotificationSettings() {
        let params = [ParametersKeys.shmoke : self.isSHMOKeEnabled!,
                      ParametersKeys.Deals: self.isDEALSEnabled!,
                      ParametersKeys.match: self.isMATCHEnabled!,
                      ParametersKeys.smo: self.isSMOEnabled!,
                      ParametersKeys.smo_iou: self.isSMOIOUEnabled!,
                      ParametersKeys.drop: self.isDROPEnabled!]
        self.interactor?.updateNotificationSettings(params as [String : Any])
    }
    func getNotificationSetting() {
        self.interactor?.getNotificationSetting()
    }
}

extension SettingsPresenter: SettingsInteractorOutputProtocol {
  func onError(value: String) {
    self.view?.onError(value: value)
  }
    func getNotificationSetting(_ value: ServerResponseModal) {
        if value.status != nil {
            if value.status == RESPONSE_STATUS.success {
                let notificationData = NotificationSetting(fromDictionary: value.response )
                self.view?.reloadView(notificationData)
            } else if value.error.count > 0 {
                self.view?.showAlert(value.error.first!)
            }
        } else {
            self.view?.onError(value: "nodata")
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
    
    

