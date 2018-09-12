//
//  NSNumber+Extension.swift
//  Jugnoo Driver
//
//  Created by socomo on 03/05/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
  
//  func formatToPrecision() -> Double {
//    let formatter = NumberFormatter()
//    let precision = ApplicationData.shared.getLoginData().currencyPrecision
//    formatter.numberStyle = .decimal
//    formatter.maximumFractionDigits = precision
//    formatter.minimumFractionDigits = precision
//    formatter.roundingMode = .halfUp
//    
//    guard let str = formatter.string(from: NSNumber.init(value: self)) , let number = formatter.number(from: str) else {
//      return self.rounded(toPlaces: precision)
//    }
//    let doubleValue = number.doubleValue
//    return doubleValue
//    
//  }
//  
//  func showToPrecision() -> String {
//    let formatter = NumberFormatter()
//    let precision = ApplicationData.shared.getLoginData().currencyPrecision
//    formatter.numberStyle = .decimal
//    formatter.maximumFractionDigits = precision
//    formatter.minimumFractionDigits = precision
//    formatter.roundingMode = .halfUp
//    
//    guard let str = formatter.string(from: NSNumber.init(value: self)) else {
//      return "\(self)"
//    }
//    return str
//    
//  }
  
}
