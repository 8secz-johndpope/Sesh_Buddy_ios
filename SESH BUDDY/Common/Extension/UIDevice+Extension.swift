//
//  UIDevice+Extension.swift
//  Jugnoo
//
//  Created by cl-macmini-67 on 9/29/17.
//  Copyright © 2017 Socomo Technologies. All rights reserved.
//

import Foundation
import UIKit

enum Model : Int {
    case simulator
    case iPod1
    case iPod2
    case iPod3
    case iPod4
    case iPod5
    case iPad2
    case iPad3
    case iPad4
    case iPhone4
    case iPhone4S
    case iPhone5
    case iPhone5S
    case iPhone5C
    case iPadMini1
    case iPadMini2
    case iPadMini3
    case iPadAir1
    case iPadAir2
    case iPadPro9_7
    case iPadPro9_7_cell
    case iPadPro12_9
    case iPadPro12_9_cell
    case iPhone6
    case iPhone6plus
    case iPhone6S
    case iPhone6Splus
    case iPhoneSE
    case iPhone7
    case iPhone7plus
    case iPhone8
    case iPhone8plus
    case iPhoneX
    case unrecognized
    
    func name() -> String {
        switch self {
        case .simulator  : return "simulator/sandbox"
        case .iPod1           : return "iPod 1"
        case .iPod2           : return "iPod 2"
        case .iPod3           : return "iPod 3"
        case .iPod4           : return "iPod 4"
        case .iPod5           : return "iPod 5"
        case .iPad2           : return "iPad 2"
        case .iPad3           : return "iPad 3"
        case .iPad4           : return "iPad 4"
        case .iPhone4         : return "iPhone 4"
        case .iPhone4S        : return "iPhone 4S"
        case .iPhone5         : return "iPhone 5"
        case .iPhone5S        : return "iPhone 5S"
        case .iPhone5C        : return "iPhone 5C"
        case .iPadMini1       : return "iPad Mini 1"
        case .iPadMini2       : return "iPad Mini 2"
        case .iPadMini3       : return "iPad Mini 3"
        case .iPadAir1        : return "iPad Air 1"
        case .iPadAir2        : return "iPad Air 2"
        case .iPadPro9_7      : return "iPad Pro 9.7\""
        case .iPadPro9_7_cell : return "iPad Pro 9.7\" cellular"
        case .iPadPro12_9     : return "iPad Pro 12.9\""
        case .iPadPro12_9_cell: return "iPad Pro 12.9\" cellular"
        case .iPhone6         : return "iPhone 6"
        case .iPhone6plus     : return "iPhone 6 Plus"
        case .iPhone6S        : return "iPhone 6S"
        case .iPhone6Splus    : return "iPhone 6S Plus"
        case .iPhoneSE        : return "iPhone SE"
        case .iPhone7         : return "iPhone 7"
        case .iPhone7plus     : return "iPhone 7 Plus"
        case .iPhone8         : return "iPhone 8"
        case .iPhone8plus     : return "iPhone 8 Plus"
        case .iPhoneX         : return "iPhone X"
        case .unrecognized    : return "?unrecognized?"
        }
    }
}

extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436 && UIDevice().userInterfaceIdiom == .phone
    }
    
     var type: Model {
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            let modelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]
        #else
            var systemInfo = utsname()
            uname(&systemInfo)
            let modelCode = withUnsafePointer(to: &systemInfo.machine) {
                $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                    ptr in String.init(validatingUTF8: ptr)
                    
                }
            }
        #endif
        
        
        
        var modelMap : [ String : Model ] = [
            "i386"       : .simulator,
            "x86_64"     : .simulator,
            "iPod1,1"    : .iPod1,
            "iPod2,1"    : .iPod2,
            "iPod3,1"    : .iPod3,
            "iPod4,1"    : .iPod4,
            "iPod5,1"    : .iPod5,
            "iPad2,1"    : .iPad2,
            "iPad2,2"    : .iPad2,
            "iPad2,3"    : .iPad2,
            "iPad2,4"    : .iPad2,
            "iPad2,5"    : .iPadMini1,
            "iPad2,6"    : .iPadMini1,
            "iPad2,7"    : .iPadMini1,
            "iPhone3,1"  : .iPhone4,
            "iPhone3,2"  : .iPhone4,
            "iPhone3,3"  : .iPhone4,
            "iPhone4,1"  : .iPhone4S,
            "iPhone5,1"  : .iPhone5,
            "iPhone5,2"  : .iPhone5,
            "iPhone5,3"  : .iPhone5C,
            "iPhone5,4"  : .iPhone5C,
            "iPad3,1"    : .iPad3,
            "iPad3,2"    : .iPad3,
            "iPad3,3"    : .iPad3,
            "iPad3,4"    : .iPad4,
            "iPad3,5"    : .iPad4,
            "iPad3,6"    : .iPad4,
            "iPhone6,1"  : .iPhone5S,
            "iPhone6,2"  : .iPhone5S,
            "iPad4,1"    : .iPadAir1,
            "iPad4,2"    : .iPadAir2,
            "iPad4,4"    : .iPadMini2,
            "iPad4,5"    : .iPadMini2,
            "iPad4,6"    : .iPadMini2,
            "iPad4,7"    : .iPadMini3,
            "iPad4,8"    : .iPadMini3,
            "iPad4,9"    : .iPadMini3,
            "iPad6,3"    : .iPadPro9_7,
            "iPad6,11"   : .iPadPro9_7,
            "iPad6,4"    : .iPadPro9_7_cell,
            "iPad6,12"   : .iPadPro9_7_cell,
            "iPad6,7"    : .iPadPro12_9,
            "iPad6,8"    : .iPadPro12_9_cell,
            "iPhone7,1"  : .iPhone6plus,
            "iPhone7,2"  : .iPhone6,
            "iPhone8,1"  : .iPhone6S,
            "iPhone8,2"  : .iPhone6Splus,
            "iPhone8,4"  : .iPhoneSE,
            "iPhone9,1"  : .iPhone7,
            "iPhone9,2"  : .iPhone7plus,
            "iPhone9,3"  : .iPhone7,
            "iPhone9,4"  : .iPhone7plus,
//            "iPhone10,1" : .iPhone8,
//            "iPhone10,2" : .iPhone8plus,
//            "iPhone10,3" : .iPhoneX
            "iPhone10,1" : .iPhone8,
            "iPhone10,4" : .iPhone8,
            "iPhone10,2" : .iPhone8plus,
            "iPhone10,5" : .iPhone8plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,6" : .iPhoneX,
        ]
        
        guard let codeOfModel = modelCode else {
           return Model.unrecognized
        }
        
        guard let modelString = String.init(validatingUTF8: codeOfModel) else {
            return Model.unrecognized
        }
        
        if let model = modelMap[modelString] {
            return model
        }
        return Model.unrecognized
    }
}
