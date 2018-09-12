//
//	ServerResponseModal.swift
//
//	Create by cl-macmini-67 on 3/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ServerResponseModal{
  
  var data : Any!
  var flag : Int!
  var error: String!
  var displayMessage : String!
  var message : String!
  var response: [String:Any]!
  var accessToken: String!
 
  
  /**
   * Instantiate the instance using the passed dictionary values to set the properties values
   */
  init(fromDictionary dictionary: [String:Any]){
    data = dictionary["data"]
    flag = dictionary["flag"] as? Int
    message = dictionary["message"] as? String
    error = dictionary["error"] as? String
    response = dictionary
    accessToken = dictionary["access_token"] as? String
    displayMessage = dictionary["display_message"] as? String
  }
  
  /**
   * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
   */
  func toDictionary() -> [String:Any]
  {
    var dictionary = [String:Any]()
    if data != nil{
      dictionary["data"] = data
    }
    if flag != nil{
      dictionary["flag"] = flag
    }
    if message != nil{
      dictionary["message"] = message
    }
    return dictionary
  }
  
}
