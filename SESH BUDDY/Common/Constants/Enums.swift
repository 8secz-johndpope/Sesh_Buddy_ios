//
//  Enums.swift
//  SESH BUDDY
//
//  Created by test on 15/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation

enum StatusTypes: Int {
    case redUP = 0
    case holding = 1
    case dry = 2
}
enum SessionType: Int {
    case SHMOKE = 1
    case MATCH = 2
    case DROP = 3
    case SMO = 4
    case none
}
enum LoginType: Int {
    case none = 0
    case facebook = 1
    case snapchat = 2
    case signupOrLoginWithEmail = 3
    
}

