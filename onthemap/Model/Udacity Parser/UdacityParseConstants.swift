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
        static let BaseURL: String = "https://parse.udacity.com/parse/classes/StudentLocation"
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
    struct APIHeaderValues {
        static let AppID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ApiKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        
    }
    struct APIHeaderKeys {
        static let ID = "X-Parse-Application-Id"
        static let Key = "X-Parse-REST-API-Key"
        static let xsrfToken = "X-XSRF-TOKEN"
        
    }
    
    struct StudentLocationItem {
        static let uniqueKey = "uniqueKey"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let mapString = "mapString"
        static let mediaURL = "mediaURL"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
}







