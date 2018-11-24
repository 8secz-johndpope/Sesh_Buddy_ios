/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Session {
	public var seshType : Int!
	public var userId : String!
	public var userName : String!
	public var seshBuddies : Array<SeshBuddies>!
	public var seshData : Array<SeshData>!


    public class func modelsFromDictionaryArray(array:NSArray) -> [Session] {
        var models:[Session] = []
        for item in array {
            models.append(Session(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let Session = Session(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Session Instance.
*/
	required public init?(dictionary: NSDictionary) {

		seshType = dictionary["seshType"] as? Int
		userId = dictionary["userId"] as? String
		userName = dictionary["userName"] as? String
        if (dictionary["seshBuddies"] != nil) { seshBuddies = SeshBuddies.modelsFromDictionaryArray(array: dictionary["seshBuddies"] as! NSArray) }
        if (dictionary["seshData"] != nil) { seshData = SeshData.modelsFromDictionaryArray(array: dictionary["seshData"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.seshType, forKey: "seshType")
		dictionary.setValue(self.userId, forKey: "userId")
		dictionary.setValue(self.userName, forKey: "userName")

		return dictionary
	}

}
