//
//  Keychain.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

class KeyChain {
    class func save(key: String, data: NSData) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
        
    }
    
    class func load(key: String) -> NSData? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef:AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return (dataTypeRef! as! NSData)
        } else {
            return nil
        }
        
        
    }
    
    class func stringToNSDATA(string : String)->NSData
    {
        let _Data = (string as NSString).data(using: String.Encoding.utf8.rawValue)
        return _Data! as NSData
        
    }
    
    
    class func NSDATAtoString(data: NSData)->String
    {
        let returned_string : String = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return returned_string
    }
    
    class func intToNSDATA(r_Integer : Int)->NSData
    {
        
        var SavedInt: Int = r_Integer
        let _Data = NSData(bytes: &SavedInt, length: MemoryLayout<Int>.size)
        return _Data
        
    }
    class func NSDATAtoInteger(_Data : NSData) -> Int
    {
        var RecievedValue : Int = 0
        _Data.getBytes(&RecievedValue, length: MemoryLayout<Int>.size)
        return RecievedValue
        
    }
    class func CreateUniqueID() -> String
    {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr:CFString = CFUUIDCreateString(nil, uuid)
        
        let nsTypeString = cfStr as NSString
        let swiftString:String = nsTypeString as String
        return swiftString
    }
    
    class func getAccessToken() -> String? {
        if let receivedData = KeyChain.load(key: UserDefaultsKeys.AccessToken) {
            let result = KeyChain.NSDATAtoString(data: receivedData)
            return result.isEmpty ? nil : result
        }
        
        return nil
        
    }
    

    class func setAccessToken(tokenString: String) {
        let data = KeyChain.stringToNSDATA(string: tokenString)
        let status = KeyChain.save(key: UserDefaultsKeys.AccessToken, data: data)
        print(status)
    }
    
}

