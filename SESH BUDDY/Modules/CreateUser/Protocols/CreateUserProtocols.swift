//
//  CreateUserProtocols.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 06/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation
import UIKit

protocol CreateUserViewProtocol: class {
    var presenter: CreateUserPresenterProtocol? { get set }
    func onError(value: String)
    func showAlert(_ string: String)
}
protocol CreateUserPresenterProtocol: class {
    var view: CreateUserViewProtocol? { get set }
    var interactor: CreateUserInteractorInputProtocol? { get set }
    var wireFrame: CreateUserWireFrameProtocol? { get set }
    var firstName: String! { get set }
    var lastName: String! { get set }
    var userName: String! { get set }
    var email: String! { get set }
    var password: String! { get set }
    var createUserType: LoginType! { get set }
    func registerUserButtonClicked()
    func createUserButtonClicked()
}
protocol CreateUserInteractorInputProtocol: class{
    var presenter: CreateUserInteractorOutputProtocol? { get set }
    func registerUser(with: [String: Any])
    func createUser(with: [String: Any])
}
protocol CreateUserInteractorOutputProtocol: class {
    func registerUserGenerate(_ value: ServerResponseModal)
    func createUserGenerate(_ value: ServerResponseModal)
}
protocol CreateUserWireFrameProtocol: class {
    static func createUserModule() -> UIViewController
    func moveToHomeScreen(_ fromView: CreateUserViewProtocol)
}
