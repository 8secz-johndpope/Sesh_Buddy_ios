//
//  Objects+Extension.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation

public extension DispatchQueue {
  
  private class func delay(delay: TimeInterval, closure: @escaping () -> Void) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
  }
  
  class func performAction(after seconds: TimeInterval, callBack: @escaping ((Bool) -> Void) ) {
    DispatchQueue.delay(delay: seconds) {
      callBack(true)
    }
  }
}

extension Dictionary {
  
  //Append Dictionary
  mutating func appendDictionary(other: Dictionary) {
    for (key, value) in other {
      self.updateValue(value, forKey:key)
    }
  }
  
  static func += <K, V> ( left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
      left.updateValue(v, forKey: k)
    }
  }
}
