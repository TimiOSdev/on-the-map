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
    
    
    init?(dictionary: [String: AnyObject]) {
        
        self.objectId = dictionary[UdacityParseClient.JSONResponseKeys.ObjectId] as? String
        self.uniqueKey = dictionary[UdacityParseClient.JSONResponseKeys.UniqueKey] as? String
        self.firstName = dictionary[UdacityParseClient.JSONResponseKeys.FirstName] as? String
        self.lastName = dictionary[UdacityParseClient.JSONResponseKeys.LastName] as? String
        self.latitude = dictionary[UdacityParseClient.JSONResponseKeys.Latitude] as? Double
        self.longitude = dictionary[UdacityParseClient.JSONResponseKeys.Longitude] as? Double
        self.mapString = dictionary[UdacityParseClient.JSONResponseKeys.MapString] as? String
        self.mediaURL = dictionary[UdacityParseClient.JSONResponseKeys.MediaURL] as? String
        self.createdAt = dictionary[UdacityParseClient.JSONResponseKeys.CreatedAt] as? String
        self.updatedAt = dictionary[UdacityParseClient.JSONResponseKeys.UpdatedAt] as? String
        
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
            students.append(StudentInformation(dictionary: result)!)
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
