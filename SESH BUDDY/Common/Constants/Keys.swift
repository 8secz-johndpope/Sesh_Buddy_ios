//
//  Keys.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 04/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation
import UIKit

//----------------------------------------SCRREN DIAMENSIONS--------------------------------------------//
var screenSize : CGRect     = UIScreen.main.bounds
var screenWidth             = screenSize.size.width
var screenHeight            = screenSize.size.height

//----------------------------------------STORYBOARDS---------------------------------------------------------------//

enum Storyboards: String {
    case authorization = "Authorization"
    case homeFlow = "HomeFlow"
    case entry = "Entry"
    
    func getStoryBoard() -> UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle: Bundle.main)
    }
    func getIntialController() -> UIViewController? {
        return self.getStoryBoard().instantiateInitialViewController()
    }
    func getHomeScreen() -> UIViewController {
        let storyBoard = Storyboards.homeFlow.getStoryBoard()
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
        return homeViewController
    }
}

var appDelegate: AppDelegate {
    guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
        fatalError("AppDelegate is not UIApplication.shared.delegate")
    }
    return delegate
}

//----------------------------------------URLS AND NETWORKING CONSTANTS--------------------------------------------//

struct AppInfo {
    static let KAppVersion = "322"
    static let DeviceType = "1"
    static let ClientId = "EEBUOvQq7RRJBxJm"
    static let password = "auyq38yr9fsdjfw38"
    static let operatorToken = "d7f228ce89b10cb02ec9fccdb47355d5"
    static let appUrl = "itms-apps://itunes.apple.com/app/id1378177428"
    static let supportEmail = "support@jugnoo.in"
    static let likeUsOnFacebook = "https://www.facebook.com/jugnoose"
    static let login_type = 1
    static func getDefaultParams() -> [String: Any] {
        let dict = ["app_version": self.KAppVersion,
                    "device_type": self.DeviceType,
                    "client_id": ClientId,
                    "customer_package_name": Bundle.main.bundleIdentifier ?? "",
                    "locale": L102Language.currentAppleLanguage(),
                    ParametersKeys.operator_token: operatorToken]
        return dict
    }
    static func deviceToken() -> String {
        return ""//UserDefaults.standard.value(forKey: UserDefaultsKeys.deviceToken) as? String ?? "123456"
    }
    // Get country code from NSLocale
    static func getPhoneCountryFromSimOrRegion() -> String {
//        let locale = Locale.current
//        let networkInfo = CTTelephonyNetworkInfo()
//        let carrier: CTCarrier? = networkInfo.subscriberCellularProvider
//        if let isoCode = carrier?.isoCountryCode, !isoCode.isEmpty {
//            print("Mobile Network iso Code ", isoCode)
//            return (locale as NSLocale).displayName(forKey: .countryCode, value: isoCode) ?? ""
//        } else {
//            if let isoCode = locale.regionCode, !isoCode.isEmpty {
//                print("Mobile Network iso Code ", isoCode)
//                return (locale as NSLocale).displayName(forKey: .countryCode, value: isoCode) ?? ""
//            }
//        }
        return ""
    }
}
