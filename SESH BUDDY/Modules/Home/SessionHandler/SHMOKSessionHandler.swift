//
//  SHMOKSessionHandler.swift
//  SESH BUDDY
//
//  Created by test on 07/10/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation

class SHMOKSessionHandler: NSObject {
    var currentSessions = [String]()
    var buddiesList = [String]()
    var selectedSeshType = ""
    var selectedStrainType = ""
    var selectedUtensilType = ""
    var selectedTime = ""
    var selectedDate = ""
    var selectedLocation = ""
    
    override init() {
        currentSessions.append("90805fish")
        currentSessions.append("90806fish")
    }
    
    func clearSession() {
         selectedSeshType = ""
         selectedStrainType = ""
         selectedUtensilType = ""
         selectedTime = ""
         selectedDate = ""
         selectedLocation = ""
    }
}
