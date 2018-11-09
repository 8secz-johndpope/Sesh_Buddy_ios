//
//  SMOSssionHandler.swift
//  SESH BUDDY
//
//  Created by test on 07/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation

class SMOSssionHandler: NSObject {
    var currentSessions = [String]()
    var buddiesList = [[String: Any]]()
    var selectedSeshType = ""
    var selectedReasonsType = ""
    var selectedTime = ""
    var selectedDate = ""
    override init() {
        currentSessions.append("90803fish")
    }
}
