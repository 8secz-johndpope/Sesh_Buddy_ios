//
//  AppColors.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 26/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
  
  
  
  //---------------------------------------------------- THEME ----------------------------------------------------//

  public class var themeDarkTextColor: UIColor {
    return bodyText//UIColor.init(red: 89, green: 89, blue: 104)
  }
  
  public class var themeNavBarColor: UIColor {
    return UIColor.init(red: 1, green: 115, blue: 0)
  }
  
  public class var themeNavBarTitleColor: UIColor {
    return .heading//UIColor.init(red: 63, green: 63, blue: 78)
  }
  
  public class var themeNavBarButtonColor: UIColor {
    return .heading//UIColor.init(red: 63, green: 63, blue: 78)
  }
  
  
  public class var themeOrange: UIColor {
    return UIColor.init(red: 0, green: 127, blue: 0)
  }
  
  public class var heading: UIColor {
    return UIColor.white
  }
  
  public class var bodyText: UIColor {
    return UIColor.init(red: 51, green: 51, blue: 51)
  }
  
  public class var white: UIColor {
    return UIColor.init(red: 255, green: 255, blue: 255)
  }
  
  public class var sideMenuBackgroundColor: UIColor {
    return UIColor.white
  }
  
  public class var sideMenuProfileBGColor: UIColor {
    return UIColor.init(red: 37, green: 42, blue: 54)
  }
  
  //---------------------------------------------------- NAVIGATION BAR ----------------------------------------------------//
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
  
    public class var orange: UIColor {
        return themeOrange
    }
    
    public class var backgroundGrey: UIColor {
        return UIColor.init(red: 244, green: 244, blue: 244)
    }
    
    public class var backgroundDarkGrey: UIColor {
        return UIColor.init(red: 157, green: 157, blue: 157)
    }
    
    public class var textfieldBorderColor: UIColor {
        return UIColor.init(red: 188, green: 188, blue: 188)
    }
    
    public class var labelTextColor: UIColor {
        return bodyText//UIColor.init(red: 25, green: 25, blue: 25)
    }
    
    public class var orangeLabelColor: UIColor {
        return themeOrange//UIColor.init(red: 254, green: 141, blue: 112)
    }
    
    public class var greyBackgroundColor: UIColor {
        return UIColor.init(red: 151, green: 151, blue: 151)
    }
    
    public class var profileHeadingColor: UIColor {
        return heading//UIColor.init(red: 253, green: 121, blue: 69)
    }
    
    public class var profileBlackTextColor: UIColor {
        return bodyText//UIColor.init(red: 47, green: 34, blue: 27)
    }
    
  
  
  
  public class var rideHistoryGreyColor: UIColor {
        return UIColor.init(red: 155, green: 155, blue: 155)
    }
    
    public class var rideHistoryRedColor: UIColor {
        return UIColor.init(red: 235, green: 86, blue: 53)
    }
    
   
    
    public class var rideHistoryRideTypeBackGroundColor: UIColor {
        return UIColor.init(red: 216, green: 216, blue: 216)
    }
    
  
  
  public class var lineViewBg: UIColor {
    return UIColor.init(red: 221, green: 221, blue: 221)
  }
  
  public class var greybackground: UIColor {
    return UIColor.init(red: 250, green: 250, blue: 250)
  }
  
  public class var greyBorder: UIColor {
    return UIColor.init(red: 182, green: 182, blue: 182)
  }
  
  public class var documentUploadGreenColor: UIColor {
    return UIColor.init(red: 121, green: 202, blue: 32)
  }
    public class var superDriverPaleGreyColor: UIColor {
        return UIColor.init(red: 245, green: 246, blue: 247)
    }
  
  public class var lightGreyColor: UIColor {
    return UIColor.init(red: 210, green: 213, blue: 219)
  }
  
  public class var greyBackgroundFillColor: UIColor {
    return UIColor.init(red: 242, green: 242, blue: 242)
  }
  public class var earningsBackground: UIColor {
    return UIColor.init(red: 42, green: 47, blue: 60)
  }
  
  public class var walletTabsBackground: UIColor {
    return UIColor.init(red: 245, green: 246, blue: 247)
  }
  
  public class var greyLine: UIColor {
    return UIColor.init(red: 219, green: 219, blue: 219)
  }
  
  public class var greySuperDriverRank: UIColor {
    return UIColor.init(red: 231, green: 231, blue: 231)
  }
  
}
