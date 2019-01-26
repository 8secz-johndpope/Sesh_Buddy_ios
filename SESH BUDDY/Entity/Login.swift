//
//  Login.swift
//  SESH BUDDY
//
//  Created by test on 14/12/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation

struct Login{
    var accessToken: String!
    var coverPic: String!
    var createdAt: String!
    var email: String!
    var fcmToken: String!
    var firstName: String!
    var lastName: String!
    var loginType: LoginType!
    var profilePic: String!
    var uid: String!
    var updatedAt: String!
    var userId: Int!
    var userName: String!
    var userStatus: StatusTypes!
    var dob: String!
    var gender: Int!
    var favoriteStrain: String!
    var aboutMe: String!
    init(fromDictionary dictionary: [String:Any]) {
        dob = dictionary["dob"] as? String
        favoriteStrain = dictionary["favoriteStrain"] as? String
        accessToken = dictionary["accessToken"] as? String
        coverPic = dictionary["coverPic"] as? String
        createdAt = dictionary["created_at"] as? String
        email = dictionary["email"] as? String
        fcmToken = dictionary["fcmToken"] as? String
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        gender = dictionary["gender"] as? Int
        aboutMe = dictionary["aboutMe"] as? String
        if let value =  dictionary["loginType"] as? Int {
            let loginEnum = LoginType.init(rawValue: value)
            loginType = loginEnum
        }
        profilePic = dictionary["profilePic"] as? String
        uid = dictionary["uid"] as? String
        updatedAt = dictionary["updated_at"] as? String
        userId = dictionary["userId"] as? Int
        userName = dictionary["userName"] as? String
        if let value =  dictionary["userStatus"] as? Int {
            let loginEnum = StatusTypes.init(rawValue: value)
            userStatus = loginEnum
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accessToken != nil{
            dictionary["accessToken"] = accessToken
        }
        if coverPic != nil{
            dictionary["coverPic"] = coverPic
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if email != nil {
            dictionary["email"] = email
        }
        if fcmToken != nil {
            dictionary["fcmToken"] = fcmToken
        }
        if firstName != nil {
            dictionary["firstName"] = firstName
        }
        if lastName != nil {
            dictionary["lastName"] = lastName
        }
        if loginType != nil {
            dictionary["loginType"] = loginType.rawValue
        }
        if profilePic != nil{
            dictionary["profilePic"] = profilePic
        }
        if uid != nil{
            dictionary["uid"] = uid
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        if userName != nil{
            dictionary["userName"] = userName
        }
        if userStatus != nil {
            dictionary["userStatus"] = userStatus.rawValue
        }
        if aboutMe != nil {
            dictionary["aboutMe"] = aboutMe
        }
        if dob != nil {
            dictionary["dob"] = dob
        }
        if gender != nil {
            dictionary["gender"] = gender
        }
        if favoriteStrain != nil {
            dictionary["favoriteStrain"] = favoriteStrain
        }
        return dictionary
    }

    
    
}
