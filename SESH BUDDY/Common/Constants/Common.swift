//
//  Common.swift
//  SESH BUDDY
//
//  Created by test on 09/11/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation

class Common: NSObject {
    
    static let share = Common()
    
    func getSeshTypeList() ->[String] {
        let seshType = ["Sess 1", "Sess 2"]
        return seshType
    }
    func getStrainTypeList() ->[String] {
        let seshType = ["Strain 1", "Strain 2"]
        return seshType
    }
    func getUtensilTypeList() ->[String] {
        let seshType = ["Utensils 1", "Utensils 2"]
        return seshType
    }
    func getGramTypeList() ->[String] {
        let seshType = ["Grams 1", "Grams 2"]
        return seshType
    }
    func getPointsTypeList() ->[String] {
        let seshType = ["Point 1", "Point 2"]
        return seshType
    }
    func getReasonsTypeList() ->[String] {
        let seshType = ["Reason 1", "Reason 2"]
        return seshType
    }
    
    func getValideString(from: String) -> String {
        var stringVal = from
        stringVal = stringVal.trimeString()
        return stringVal
    }
    func getDummySessionArray() -> [[String : Any]]{
        let seshType = ["key": "SESH TYPE:",
                        "value": "Sesh Type"]
        
        let seshType1 = ["key": "POINTS:",
                        "value": "Point1"]
        
        let seshType2 = ["key": "STRAIN:",
                        "value": "Strain1"]
        
        let seshType3 = ["key": "DATE:",
                        "value": "Date1"]
        
        let seshType4 = ["key": "TIME:",
                        "value": "Time1"]
        
        let seshType5 = ["key": "LOCATION:",
                        "value": "Location1"]
        
        let seshType6 = ["key": "BUDDIES:",
                        "value": "Buddy1"]
        
        let seshType7 = ["key": "UTENSILS:",
                         "value": "Utensil1"]
        
        let dummySessionArray = [seshType, seshType1, seshType2, seshType3, seshType4, seshType5, seshType6, seshType7]
        return dummySessionArray
    }
    func getSessionsArray()-> [Session] {
        let sessionDict =         [
        
                    "seshType": 4,
                    "userId": "60805fish",
                    "userName": "90fish",
                    "seshBuddies": [[
                    "profilePic": "url",
                    "buddyName": "edfwe",
                    "qualityRating": 1,
                    "quantityRating": 2,
                    "rollsRating": 3,
                    "comment": "fdsfsd",
                    "buddyId": 233
                        ], [
                            "profilePic": "url",
                            "buddyName": "edfwe",
                            "qualityRating": 1,
                            "quantityRating": 2,
                            "rollsRating": 3,
                            "comment": "fdsfsd",
                            "buddyId": 233
                        ], [
                            "profilePic": "url",
                            "buddyName": "edfwe",
                            "qualityRating": 1,
                            "quantityRating": 2,
                            "rollsRating": 3,
                            "comment": "fdsfsd",
                            "buddyId": 233
                        ], [
                            "profilePic": "url",
                            "buddyName": "edfwe",
                            "qualityRating": 1,
                            "quantityRating": 2,
                            "rollsRating": 3,
                            "comment": "fdsfsd",
                            "buddyId": 233
                        ], [
                            "profilePic": "url",
                            "buddyName": "edfwe",
                            "qualityRating": 1,
                            "quantityRating": 2,
                            "rollsRating": 3,
                            "comment": "fdsfsd",
                            "buddyId": 233
                        ]],
                    "seshData": [[
                    "id": 1,
                    "key": "SESH TYPE:",
                    "value": "SESH TYPE1",
                    "buddies": [[
                    "buddyId": 2342,
                    "buddyName": "ewdwed"
                    ], [
                    "buddyId": 2342,
                    "buddyName": "ewdwed"
                    ]
                    ]
                        ],
                                 [
                                    "id": 2,
                                    "key": "POINTS:",
                                    "value": "POINTS 1",
                                    "buddies": [[
                                        "buddyId": 2342,
                                        "buddyName": "ewdwed"
                                        ], [
                                            "buddyId": 2342,
                                            "buddyName": "ewdwed"
                                        ]
                                    ]
                        ],
                                 [
                                    "id": 3,
                                    "key": "STRAIN:",
                                    "value": "STRAIN 1",
                                    "buddies": [[
                                        "buddyId": 2342,
                                        "buddyName": "ewdwed"
                                        ], [
                                            "buddyId": 2342,
                                            "buddyName": "ewdwed"
                                        ]
                                    ]
                        ],
                                 [
                                    "id": 4,
                                    "key": "DATE:",
                                    "value": "DATE 1",
                                    "buddies": [[
                                        "buddyId": 2342,
                                        "buddyName": "ewdwed"
                                        ], [
                                            "buddyId": 2342,
                                            "buddyName": "ewdwed"
                                        ]
                                    ]
                        ],
                                 [
                                    "id": 5,
                                    "key": "TIME:",
                                    "value": "TIME 1",
                                    "buddies": [[
                                        "buddyId": 2342,
                                        "buddyName": "ewdwed"
                                        ], [
                                            "buddyId": 2342,
                                            "buddyName": "ewdwed"
                                        ]
                                    ]
                        ],
                                 [
                                    "id": 6,
                                    "key": "LOCATION:",
                                    "value": "LOCATION 1",
                                    "buddies": [[
                                        "buddyId": 2342,
                                        "buddyName": "ewdwed"
                                        ], [
                                            "buddyId": 2342,
                                            "buddyName": "ewdwed"
                                        ]
                                    ]
                        ],
                                 [
                                    "id": 8,
                                    "key": "UTENSILS:",
                                    "value": "UTENSILS 1",
                                    "buddies": [[
                                        "buddyId": 2342,
                                        "buddyName": "ewdwed"
                                        ], [
                                            "buddyId": 2342,
                                            "buddyName": "ewdwed"
                                        ]
                                    ]
                        ]]] as [String : Any]
        
        let sessionsData = Session.modelsFromDictionaryArray(array: [sessionDict])
        return sessionsData
    }
}
