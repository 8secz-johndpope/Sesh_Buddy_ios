//
//  SMOSssionHandler.swift
//  SESH BUDDY
//
//  Created by test on 07/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation

class SMOSssionHandler: NSObject {
    var currentSessions = [[String: Any]]()
    var buddiesList = [[String: Any]]()
    override init() {
        currentSessions.append([:])
    }
}
