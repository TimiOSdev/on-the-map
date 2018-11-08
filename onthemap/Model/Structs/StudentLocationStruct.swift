//
//  StudentLocationStruct.swift
//  onthemap
//
//  Created by Tim McEwan on 11/1/18.
//  Copyright © 2018 sudo. All rights reserved.
//

import MapKit
import Foundation

struct StudentInformation {
    
    let createdAt: String?
    let firstName: String?
    let lastName: String?
    let latitude: Double?
    let longitude: Double?
    let mapString: String?
    let mediaURL: String?
    let objectId : String?
    let uniqueKey: String?
    let updatedAt: String?
    
    
    init(_ dictionary: [String: AnyObject]) {
        objectId = dictionary["objectId"] as? String
        uniqueKey = dictionary["uniqueKey"] as? String
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        mapString = dictionary["mapString"] as? String
        mediaURL = dictionary["mediaURL"] as? String
        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        createdAt = dictionary["createdAt"] as? String
        updatedAt = dictionary["updatedAt"] as? String
        
    }
    
    struct UserData {
        
        
        static var uniqueKey = UdacityParseClient.StudentLocationItem.uniqueKey
        static var firstName = UdacityParseClient.StudentLocationItem.firstName
        static var lastName = UdacityParseClient.StudentLocationItem.lastName
        static var objectId = ""
        static var latitude = 0.0
        static var longitude = 0.0
        static var mapString = ""
        static var mediaURL = ""
    }
    
    static func locationsFromResults(_ results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var students = [StudentInformation]()
        
        for result in results {
            students.append(StudentInformation(result))
        }
        
        return students
    }
    
    struct NewUserLocation {
        static var mapString = ""
        static var mediaURL = ""
        static var latitude = 0.0
        static var longitude = 0.0
        static var objectId = ""
    }
}
var arrayOfStudentLocations = [StudentInformation]() 
