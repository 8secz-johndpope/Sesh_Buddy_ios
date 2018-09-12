//
//  L102Language.swift
//  Jugnoo
//
//  Created by Divyansh Bhardwaj on 17/04/18.
//  Copyright © 2018 Socomo Technologies. All rights reserved.
//

import Foundation
import UIKit

// constants
let APPLE_LANGUAGE_KEY = "AppleLanguages"
/// L102Language



@objcMembers
class L102Language: NSObject {
  
  /// get current Apple language
  class func currentAppleLanguage() -> String {
    guard let langArray = UserDefaults.standard.object(forKey: APPLE_LANGUAGE_KEY) as? [String], langArray.count > 0 else {
      return "en"
    }
    let current = langArray.first
    return current!
  }
  /// set @lang to be the first in Applelanguages list
  class func setAppleLAnguageTo(lang: String) {
    UserDefaults.standard.set([lang, L102Language.currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
    UserDefaults.standard.synchronize()
  }
  
  class func setAppleLAnguages(_ lang: [String]) {
    UserDefaults.standard.set(lang, forKey: APPLE_LANGUAGE_KEY)
    UserDefaults.standard.synchronize()
  }
  
  class func getLangArray() -> [String] {
    return UserDefaults.standard.object(forKey: APPLE_LANGUAGE_KEY) as? [String] ?? ["en"]
    
  }
  
  class func changeAppLanguage(_ selectedLanguage: String) {
    
    L102Language.setAppleLAnguageTo(lang: selectedLanguage)
    
    if Locale.characterDirection(forLanguage: L102Language.currentAppleLanguage()) == .rightToLeft {
      
      UIView.appearance().semanticContentAttribute = .forceRightToLeft
      UITextField.appearance().semanticContentAttribute = .forceRightToLeft
      UIButton.appearance().semanticContentAttribute = .forceRightToLeft
      UIImageView.appearance().semanticContentAttribute = .forceRightToLeft
      UITableView.appearance().semanticContentAttribute = .forceRightToLeft
      UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
      UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
      UICollectionViewCell.appearance().semanticContentAttribute = .forceRightToLeft
      UILabel.appearance().semanticContentAttribute = .forceRightToLeft
      UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
      UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
      
    } else {
      
      UIView.appearance().semanticContentAttribute = .forceLeftToRight
      UITextField.appearance().semanticContentAttribute = .forceLeftToRight
      UIButton.appearance().semanticContentAttribute = .forceLeftToRight
      UIImageView.appearance().semanticContentAttribute = .forceLeftToRight
      UITableView.appearance().semanticContentAttribute = .forceLeftToRight
      UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
      UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
      UICollectionViewCell.appearance().semanticContentAttribute = .forceLeftToRight
      UILabel.appearance().semanticContentAttribute = .forceLeftToRight
      UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
      UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
      
    }
  }
  
}

