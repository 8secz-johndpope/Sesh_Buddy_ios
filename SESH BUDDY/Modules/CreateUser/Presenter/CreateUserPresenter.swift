//
//  CreateUserPresenter.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 06/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation

class CreateUserPresenter: CreateUserPresenterProtocol {
    
    weak var view: CreateUserViewProtocol?
    var interactor: CreateUserInteractorInputProtocol?
    var wireFrame: CreateUserWireFrameProtocol?
    
    func createUserNuttonClicked() {
          self.wireFrame?.moveToHomeScreen(self.view!)
    }
}
extension CreateUserPresenter: CreateUserInteractorOutputProtocol {
    func createUserGenerate(_ value: ServerResponseModal) {
        self.wireFrame?.moveToHomeScreen(self.view!)
    }
}

