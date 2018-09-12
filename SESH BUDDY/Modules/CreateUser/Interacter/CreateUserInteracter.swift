//
//  CreateUserInteracter.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 06/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation

class CreateUserInteracter: CreateUserInteractorInputProtocol {
    var presenter: CreateUserInteractorOutputProtocol?
    
    func createUser(with: [String: Any]) {
        let response = ServerResponseModal(fromDictionary: [:])
        self.presenter?.createUserGenerate(response)
    }
}
