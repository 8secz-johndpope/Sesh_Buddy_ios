//
//  LoginInteractor.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import  Alamofire

class SettingsInteractor: SettingsInteractorInputProtocol {
    
  var presenter: SettingsInteractorOutputProtocol?
  
  func generateOtpWith(_ params: [String: Any]) {
  }
    func getNotificationSetting() {
        HTTPRequest.init(method: HTTPMethod.post, path: Urls.getNotificationSetting, parameters: nil, encoding: .json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: true).headers(headers: AppInfo.getHeader())
            .handler(httpModel: false) { (response: HTTPResponse) in
                print(response.value ?? "No result")
                let serverResponse = response.getServerResponseModal()
                if response.value == nil {
                    self.presenter?.onError(value: "Please check your internet connection")
                } else {
                    self.presenter?.getNotificationSetting(serverResponse)
                }
        }
    }
    func updateNotificationSettings(_ params: [String: Any]) {
        HTTPRequest.init(method: HTTPMethod.post, path: Urls.updateNotificationSetting, parameters: params, encoding: .json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: true).headers(headers: AppInfo.getHeader())
            .handler(httpModel: false) { (response: HTTPResponse) in
                print(response.value ?? "No result")
                let serverResponse = response.getServerResponseModal()
                if response.value == nil {
                    self.presenter?.onError(value: "Please check your internet connection")
                } else {
                    self.presenter?.getNotificationSetting(serverResponse)
                }
        }
    }
}

extension SettingsInteractor: SettingsDataManagerOutputProtocol {
  func onError(value: String) {
    
  }
  
  func generatedOtpWith(_ value: ServerResponseModal) {
    presenter?.generatedOtpWith(value)
  }
 
}
