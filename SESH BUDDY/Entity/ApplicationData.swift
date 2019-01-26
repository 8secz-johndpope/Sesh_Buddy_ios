//
//  ApplicationData.swift
//  SESH BUDDY
//
//  Created by test on 15/12/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation
import Alamofire

class ApplicationData: NSObject {
    
    static let shared = ApplicationData()
    fileprivate var loginData : Login!
    
    // MARK: Get user data
    func getLoginData() -> Login {
        return loginData
    }
    func checkLoginData() -> Bool {
        return loginData != nil
    }
    func setLoginData(_ data: Login) {
        self.loginData = data
        UserDefaults.standard.set(self.loginData.toDictionary(), forKey: keyLoginData)
        UserDefaults.standard.synchronize()
        self.setAccessToken(data.accessToken)
    }
    func setAccessToken(_ string: String) {
        KeyChain.setAccessToken(tokenString: string)
    }
    func removeAllData() {
        self.setAccessToken("")
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        let loginModule = LoginWireFrame.createLoginWithOTPModuleWithoutNav()
        appDelegate.changeVisibleRootController(loginModule)
        
    }
}
