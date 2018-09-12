//
//  UIColor+Extension.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 24/04/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
  
  /**
   Returns image with size 1x1px of certain color.
   */
    
  public class func imageWithColor(_ color : UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    guard let context = UIGraphicsGetCurrentContext() else {
      return UIImage()
    }
    
    context.setFillColor(color.cgColor)
    context.fill(rect)
    
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
      return UIImage()
    }
    UIGraphicsEndImageContext()
    
    return image
  }
    
}
