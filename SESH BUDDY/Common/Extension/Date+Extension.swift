//
//  Date+Extension.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 21/05/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation

extension Date {
  
  func getStringFromDate(_ format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") ->String {
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = format
    dateStringFormatter.timeZone = TimeZone.autoupdatingCurrent
    return dateStringFormatter.string(from: self)
  }
}
