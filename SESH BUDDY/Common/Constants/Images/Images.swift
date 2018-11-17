//
//  Images.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 26/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

struct ThemeImages {
    static let stillBackground = UIImage.imageWithColor(.orange)
    static let appLogo = #imageLiteral(resourceName: "logo")
}

struct Icons {
    static let menu = #imageLiteral(resourceName: "menu")
    static let add = #imageLiteral(resourceName: "add")
    static let back = #imageLiteral(resourceName: "back")
    static let facebook = #imageLiteral(resourceName: "facebook")
    static let snapchat = #imageLiteral(resourceName: "snapchat")
    static let profilePlaceHolder = #imageLiteral(resourceName: "profilePlaceholder")
    static let home = #imageLiteral(resourceName: "home")
    static let deal = #imageLiteral(resourceName: "deal")
    static let history = #imageLiteral(resourceName: "history")
    static let rating = #imageLiteral(resourceName: "rating")
    static let session = #imageLiteral(resourceName: "session")
    static let buddies = #imageLiteral(resourceName: "buddies")
    static let setting = #imageLiteral(resourceName: "settings")

    //MARK: STATUS ICONS
    
    static let plus_black = #imageLiteral(resourceName: "plus_black")
    static let plus_green = #imageLiteral(resourceName: "plus_green")
    static let plus_brown = #imageLiteral(resourceName: "plus_brown")
    
    //MARK: PROFILE
    static let edit = #imageLiteral(resourceName: "edit")
    
    //MARK: COMMON
    static let dropDown = UIImage(named: "dropDown")
    static let plusRound = UIImage(named: "plus")
    static let delete = UIImage(named: "delete")?.coloredImage(color: .white)
    static let starGreen = UIImage(named: "starGreen")
    static let starGray = UIImage(named: "starGray")
    static let splash = UIImage(named: "splash")
}

