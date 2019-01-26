//
//  CreateUserPresenter.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 06/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation

class CreateUserPresenter: CreateUserPresenterProtocol {
    
    
    var firstName: String!
    var lastName: String!
    var userName: String!
    var email: String!
    var password: String!
    var createUserType: LoginType!
    
    weak var view: CreateUserViewProtocol?
    var interactor: CreateUserInteractorInputProtocol?
    var wireFrame: CreateUserWireFrameProtocol?
    
    func registerUserButtonClicked() {
        let params = [ParametersKeys.firstName: firstName!,
                      ParametersKeys.lastName: lastName!,
                      ParametersKeys.userName: userName!,
                      ParametersKeys.email: email!,
                      ParametersKeys.password: password!,
                      ParametersKeys.loginType: LoginType.signupOrLoginWithEmail.rawValue,
                      ParametersKeys.fcmToken: fcmToken
            ] as [String : Any]
        self.interactor?.registerUser(with: params)
    }
    func createUserButtonClicked() {
        var params = [ParametersKeys.firstName: firstName!,
                      ParametersKeys.lastName: lastName!,
                      ParametersKeys.userName: userName!,
                      ParametersKeys.loginType: createUserType.rawValue,
                      ParametersKeys.fcmToken: fcmToken
            ] as [String : Any]
        
        switch createUserType! {
        case .facebook:
            self.interactor?.createUser(with: params)
        case .snapchat:
            self.interactor?.createUser(with: params)
        case .signupOrLoginWithEmail:
            self.interactor?.createUser(with: params)
        default:
            break
        }
    }
}
extension CreateUserPresenter: CreateUserInteractorOutputProtocol {
    func registerUserGenerate(_ value: ServerResponseModal) {
        if value.status != nil {
            if value.status == RESPONSE_STATUS.success {
                let loginData = Login(fromDictionary: value.data as! [String : Any] )
                ApplicationData.shared.setLoginData(loginData)
                self.wireFrame?.moveToHomeScreen(self.view!)
            } else if value.error.count > 0 {
                self.view?.showAlert(value.error.first!)
            }
        } else {
            self.view?.showAlert("Please check your internet connection")
        }
    }
    func createUserGenerate(_ value: ServerResponseModal) {
        
        if value.status != nil {
            if value.status == RESPONSE_STATUS.success {
                let loginData = Login(fromDictionary: value.data as! [String : Any] )
                ApplicationData.shared.setLoginData(loginData)
                if loginData.userName != nil, !loginData.userName.isEmpty {
                    self.wireFrame?.moveToHomeScreen(self.view!)
                } else {
                    if value.message != nil {
                        self.view?.showAlert(value.message)
                    }
                }
            } else if value.error.count > 0 {
                self.view?.showAlert(value.error.first!)
            }
        } else {
            self.view?.showAlert("Please check your internet connection")
        }
        
        
    }
}

