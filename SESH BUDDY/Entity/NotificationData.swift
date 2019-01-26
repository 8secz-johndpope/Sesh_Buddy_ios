//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct NotificationData{

	var createdAt : String!
	var id : Int!
	var seshDeals : Bool!
	var seshDrop : Bool!
	var seshMatch : Bool!
	var seshShmoke : Bool!
	var seshSmo : Bool!
	var seshSmoIou : Bool!
	var uid : String!
	var updatedAt : String!
	var userId : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		createdAt = dictionary["created_at"] as? String
		id = dictionary["id"] as? Int
		seshDeals = dictionary["seshDeals"] as? Bool
		seshDrop = dictionary["seshDrop"] as? Bool
		seshMatch = dictionary["seshMatch"] as? Bool
		seshShmoke = dictionary["seshShmoke"] as? Bool
		seshSmo = dictionary["seshSmo"] as? Bool
		seshSmoIou = dictionary["seshSmoIou"] as? Bool
		uid = dictionary["uid"] as? String
		updatedAt = dictionary["updated_at"] as? String
		userId = dictionary["userId"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if id != nil{
			dictionary["id"] = id
		}
		if seshDeals != nil{
			dictionary["seshDeals"] = seshDeals
		}
		if seshDrop != nil{
			dictionary["seshDrop"] = seshDrop
		}
		if seshMatch != nil{
			dictionary["seshMatch"] = seshMatch
		}
		if seshShmoke != nil{
			dictionary["seshShmoke"] = seshShmoke
		}
		if seshSmo != nil{
			dictionary["seshSmo"] = seshSmo
		}
		if seshSmoIou != nil{
			dictionary["seshSmoIou"] = seshSmoIou
		}
		if uid != nil{
			dictionary["uid"] = uid
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if userId != nil{
			dictionary["userId"] = userId
		}
		return dictionary
	}

}
