//
//  Fonts.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 26/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

enum Fonts : String {
  case mavenProRegular = "MavenPro-Regular"
  case mavenProMedium = "MavenPro-Medium"
  case mavenProBold = "MavenPro-Bold"
//  case latoRegular = "MavenPro-Regular"
//  case mavenProMedium = "Lato-Semibold"
//  case latoLight = "Lato-Light"
  
  func getFont(_ size: CGFloat) -> UIFont {
    return UIFont.init(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
  }
}
