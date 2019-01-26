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
var navigationBarHeight     = 44

//----------------------------------------USER DEFAULT--------------------------------------------//
let kFBDetailInfo          = "facebookUserDetail"
//----------------------------------------APP KEYS--------------------------------------------//
let kFacebookAppID         = "370114566895189"
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
extension AppDelegate {
    var baseURL: String {
        return Environment.live.getBaseUrl()
    }
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
                    "locale": L102Language.currentAppleLanguage()
                    ]
        return dict
    }
    
    static func getHeader() -> [String: String] {
        let header = [ParametersKeys.platform : "1",
                      ParametersKeys.accessToken: KeyChain.getAccessToken() ?? "",
                      ParametersKeys.userId: "\(ApplicationData.shared.getLoginData().userId!)"
            ] as [String : String]
        return header
    }
    static var selectedStatusType: StatusTypes = ApplicationData.shared.getLoginData().userStatus
    static func setCurrentSelectedStatus(type: StatusTypes){
        switch type {
        case .redUP:
            selectedStatusType = .redUP
        case .holding:
            selectedStatusType = .holding
        case .dry:
            selectedStatusType = .dry
        }
        
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
//----------------------------------------SESH TYPE --------------------------------------------//
let SHMOKE =  "SHMOKE"
let DROP =  "DROP"
let SMO =  "SMO"
let MATCH =  "MATCH"
//----------------------------------------FCM KEYS --------------------------------------------//
let fcmToken    = "dfgdfg"
//----------------------------------------DATE FORMATTER --------------------------------------------//
let sessionDateFormate  =   "MMMM dd, yyyy"

let snapchatClientID     =   "526a91cc-8033-4a18-9479-0f6fb6edd9b3"// TEST "4620359d-b325-475f-8ac3-63b60a72a8b1"


struct Urls {
    static let register = "register"
    static let logout = "logout"
    static let getNotificationSetting = "getNotificationSetting"
    static let updateNotificationSetting = "updateNotificationSetting"
    static let updateUserStatus = "updateUserStatus"
    static let login  = "login"
    static let createUsername = "createUsername"
    static let updateImage = "updateImage"
    static let editProfile = "editProfile"
}
enum Regex: String {
    case phoneNumber = "^((\\+)|(00))[0-9]{6,14}$"
    case email = "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,})$"
    case phoneNumberWithoutZero = "^[1-9][0-9]*$"
    case noSpecialCharacter = ".*[^A-Za-z0-9].*"
    case password = ""
    func validate(_ string: String) -> Bool {
        let Test = NSPredicate(format:"SELF MATCHES %@", self.rawValue)
        if Test.evaluate(with: string) {
            return true
        }
        return false
    }
    func validatePassword(_ string: String) -> Bool {
        guard  string.count > 5 else {
            return false
        }
        return true
    }
}
enum Environment: Int {
    case live
    case test
    case dev
    func getBaseUrl() -> String {
        switch self {
        case .live:
            return "https://upbrighterservices.com/mob-app/sesh_buddy/user"
        case .test:
            return "https://test.jugnoo.in:8012"
        case .dev:
            return "https://test.jugnoo.in:8012"
        
        }
    }
    
    func getServerName() -> String {
        switch self {
        case .live:
            return "Live"
        case .dev:
            return "Dev"
        case .test:
            return "Test"
   }
}
}
//----------------------------------------USER DEFAULT --------------------------------------------//
let keyLoginData            = "loginData"
struct UserDefaultsKeys {
    static let AccessToken = "kDriverAccessToken"
    static let KEY_IS_FIRST_TIME_USER = "is_user_first_time"
}
struct RESPONSE_STATUS {
    static let success          =       1
    static let failure          =       0
}
let platform    = "1"
