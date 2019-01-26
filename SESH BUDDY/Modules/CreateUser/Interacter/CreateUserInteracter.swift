//
//  CreateUserInteracter.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 06/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation
import Alamofire

class CreateUserInteracter: CreateUserInteractorInputProtocol {
    var presenter: CreateUserInteractorOutputProtocol?
    
    let header = [ParametersKeys.platform : "1"
                  ]
    func registerUser(with: [String: Any]) {
        HTTPRequest.init(method: HTTPMethod.post, path: Urls.register, parameters: with, encoding: .json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: true).headers(headers: header)
            .handler(httpModel: false) { (response: HTTPResponse) in
                print(response.value ?? "No result")
                let serverResponse = response.getServerResponseModal()
                self.presenter?.registerUserGenerate(serverResponse)
        }
    }
    func createUser(with: [String: Any]) {
        HTTPRequest.init(method: HTTPMethod.post, path: Urls.createUsername, parameters: with, encoding: .json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: true).headers(headers: AppInfo.getHeader())
            .handler(httpModel: false) { (response: HTTPResponse) in
                print(response.value ?? "No result")
                let serverResponse = response.getServerResponseModal()
                self.presenter?.createUserGenerate(serverResponse)
        }
    }
}
