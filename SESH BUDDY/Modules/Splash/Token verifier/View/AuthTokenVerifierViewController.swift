//
//  AuthTokenVerifierViewController.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 26/04/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import UIKit

class AuthTokenVerifierViewController: UIViewController {

  var presenter: AuthTokenVerifierPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
       presenter?.viewDidLoad()
    }
}

extension AuthTokenVerifierViewController: AuthTokenVerifierViewProtocol {
  func showAlert(_ string: String) {
    UIAlertController.presentAlert(title: nil, message: string, style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
  }
}
