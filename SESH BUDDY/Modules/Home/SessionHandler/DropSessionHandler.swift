//
//  DropSessionHandler.swift
//  SESH BUDDY
//
//  Created by test on 07/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation

class DropSessionHandler: NSObject {
    var currentSessions = [String]()
    var buddiesList = [String]()
    var selectedSeshType = ""
    var selectedPointType = ""
    var selectedStrainType = ""
    var selectedUtensilType = ""
    var selectedLocation = ""
    var selectedTime = ""
    var selectedDate = ""
    override init() {
        currentSessions.append("90801fish")
    }
    func clearSession() {
         selectedSeshType = ""
         selectedPointType = ""
         selectedStrainType = ""
         selectedUtensilType = ""
         selectedLocation = ""
         selectedTime = ""
         selectedDate = ""
    }
}
