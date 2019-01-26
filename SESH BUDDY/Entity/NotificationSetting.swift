//
//	NotificationSetting.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct NotificationSetting{

	var data : NotificationData!
	var errorMessage : [AnyObject]!
	var message : String!
	var platform : Int!
	var status : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let dataData = dictionary["data"] as? [String:Any]{
				data = NotificationData(fromDictionary: dataData)
			}
		errorMessage = dictionary["errorMessage"] as? [AnyObject]
		message = dictionary["message"] as? String
		platform = dictionary["platform"] as? Int
		status = dictionary["status"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if data != nil{
			dictionary["data"] = data.toDictionary()
		}
		if errorMessage != nil{
			dictionary["errorMessage"] = errorMessage
		}
		if message != nil{
			dictionary["message"] = message
		}
		if platform != nil{
			dictionary["platform"] = platform
		}
		if status != nil{
			dictionary["status"] = status
		}
		return dictionary
	}
}
