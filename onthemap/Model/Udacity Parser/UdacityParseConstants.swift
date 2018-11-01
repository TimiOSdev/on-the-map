//
//  UdacityParseConstants.swift
//  onthemap
//
//  Created by Tim McEwan on 11/1/18.
//  Copyright © 2018 sudo. All rights reserved.
//

extension UdacityParseClient {
    
    struct Constants {
        
        
        //Udacity Authentication Properties
        static let Username = "username"
        static let Password = "password"
        static let Udacity = "udacity"
        static let AuthorizationURL = "https://www.udacity.com/api/session"
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        static let Udacity = "udacity"
        static let UserName = "username"
        static let Password = "password"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        static let Results = "results"
        
        
        
        // MARK: Students
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        
    }
    
}







