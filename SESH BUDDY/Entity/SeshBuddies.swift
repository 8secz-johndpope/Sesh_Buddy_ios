/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class SeshBuddies {
	public var profilePic : String?
	public var buddyName : String?
	public var qualityRating : NSNumber!
	public var quantityRating : NSNumber!
	public var rollsRating : NSNumber!
	public var comment : String!
	public var buddyId : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let seshBuddies_list = SeshBuddies.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of SeshBuddies Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [SeshBuddies]
    {
        var models:[SeshBuddies] = []
        for item in array
        {
            models.append(SeshBuddies(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let seshBuddies = SeshBuddies(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: SeshBuddies Instance.
*/
	required public init?(dictionary: NSDictionary) {

		profilePic = dictionary["profilePic"] as? String
		buddyName = dictionary["buddyName"] as? String
		qualityRating = dictionary["qualityRating"] as? NSNumber
		quantityRating = dictionary["quantityRating"] as? NSNumber
		rollsRating = dictionary["rollsRating"] as? NSNumber
		comment = dictionary["comment"] as? String
		buddyId = dictionary["buddyId"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.profilePic, forKey: "profilePic")
		dictionary.setValue(self.buddyName, forKey: "buddyName")
		dictionary.setValue(self.qualityRating, forKey: "qualityRating")
		dictionary.setValue(self.quantityRating, forKey: "quantityRating")
		dictionary.setValue(self.rollsRating, forKey: "rollsRating")
		dictionary.setValue(self.comment, forKey: "comment")
		dictionary.setValue(self.buddyId, forKey: "buddyId")

		return dictionary
	}

}
