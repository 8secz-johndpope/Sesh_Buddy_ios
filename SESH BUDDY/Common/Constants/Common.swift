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
}
