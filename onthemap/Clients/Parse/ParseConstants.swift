//
//  ParseConstants.swift

import UIKit
import MapKit

extension ParseClient {


struct JSONResponseKeys {
    static let objectId = "objectId"
    static let uniqueKey = "uniqueKey"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let mapString = "mapString"
    static let mediaURL = "mediaURL"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let createdAt = "createdAt"
    static let updatedAt = "updatedAt"
    static let ACL = "ACL"
}
    

struct UsersLocation {
   static let studentsLocationResults = "results"
}
    
    struct JSONBodyKeys {
        static let objectId = JSONResponseKeys.objectId
        static let uniqueKey = Constants.UniqueKeyValue
        static let firstName = JSONResponseKeys.firstName
        static let lastName = JSONResponseKeys.lastName
        static let mapString = JSONResponseKeys.mapString
        static let mediaURL = JSONResponseKeys.mediaURL
        static let latitude = JSONResponseKeys.latitude
        static let longitude = JSONResponseKeys.longitude
        
    }
    
struct Constants {
    
    static let queryName = "where"
    
    
    static let scheme = "https"
    static let host = "parse.udacity.com"
    static let path = "/parse/classes/StudentLocation"
    static let UniqueKeyValue = "1234"
    static let queryValues = "{\"uniqueKey\": \"1234\"}"

   
    
    
    }
    
    

}

