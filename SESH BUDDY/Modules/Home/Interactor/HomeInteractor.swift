//
//  LoginInteractor.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
 
  var presenter: HomeInteractorOutputProtocol?
    
}

extension HomeInteractor: HomeDataManagerOutputProtocol {

    
  func onError(value: String) {
    
  }
}
