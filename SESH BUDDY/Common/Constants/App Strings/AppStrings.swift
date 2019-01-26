//
//  AppStrings.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 26/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation

struct AppStrings {
    static let Login = "LOGIN"
    static let Register = "REGISTER"
    static let Ok = "OK"
    static let Cancel = "Cancel"
    static let Do_you_want_to_make_call_to = "Do you want to make call to"
    static func getBusinessName() -> String {
        return "Sesh Buddy"
    }
    static let SHMOKE = "SHMOKE"
    static let DROP = "DROP"
    static let MATCH = "MATCH"
    static let SMO = "SMO"
    
    static let BUDDYUP = "BUDDY UP"
    static let sesh_type = "SESH TYPE:"
    static let point = "POINTS:"
    static let straint = "STRAIN:"
    static let time = "TIME:"
    static let location = "LOCATION:"
    static let utensils = "UTENSILS:"
    static let buddies = "BUDDIES:"
    static let gram = "GRAM:"
    static let reason = "REASON:"
    static let date = "DATE:"
}


struct ParametersKeys {
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let userName = "userName"
    static let email = "email"
    static let password = "password"
    static let platform = "platform"
    static let loginType = "loginType"
    static let fcmToken = "fcmToken"
    static let accessToken = "accessToken"
    static let userId = "userId"
    static let userStatus = "userStatus"
    static let profilePic = "profilePic"
    static let coverPic = "coverPic"
    static let shmoke = "shmoke"
    static let match = "match"
    static let drop = "drop"
    static let smo = "smo"
    static let Deals = "deals"
    static let smo_iou = "smo_iou"
    static let img_pic =  "img_pic"
    static let imageType = "imageType"
    static let dob = "dob"
    static let gender = "gender"
    static let aboutMe = "aboutMe"
    static let favoriteStrain = "favoriteStrain"
}

struct HardCodeValue {
    static let owned = "Owned"
}
