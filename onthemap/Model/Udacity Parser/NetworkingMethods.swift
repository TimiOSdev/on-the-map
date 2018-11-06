//
//  NetworkingMethods.swift
//  onthemap
//
//  Created by Tim McEwan on 11/1/18.
//  Copyright © 2018 sudo. All rights reserved.
//

import UIKit
import Foundation


extension UdacityParseClient {
    
    
    func Login(userName: String, password:String,  completionHandlerForLogin: @escaping (_ success: Bool?, _ error: String?) -> Void) {
        
        let parameters = [UdacityParseClient.Constants.Username: UdacityParseClient.Constants.Password]
        let logonRequestURL: String = UdacityParseClient.Constants.AuthorizationURL
        let jsonBody = "{\"\(UdacityParseClient.Constants.Udacity)\": {\"\(UdacityParseClient.Constants.Username)\": \"\(userName)\",\"\(UdacityParseClient.JSONBodyKeys.Password)\": \"\(password)\"}}"
        
        /* Make the request */
        let _ = taskForPOSTSession(logonRequestURL, parameters: parameters as [String:AnyObject], jsonBody: jsonBody) { (success, error) in
            
            if let error = error {
                print(error)
                completionHandlerForLogin(false, "Login Failed. Please check your username/password and try again!")
                
            } else {
                completionHandlerForLogin(true, nil)
            }
        }
    }
    
    func getStudentLocations(_ completionHandlerForLocations: @escaping (_ result: [StudentInformation]?, _ error: NSError?) -> Void) {
        
        /*  set relevant URL for requesting location data*/
        let pinDisplayRequest: String = "https://parse.udacity.com/parse/classes/StudentLocation"
        
        /* Make request */
        let _ = getTheData(pinDisplayRequest) { (result, error) in
            
            /* Send data to the completion handler */
            if let error = error {
                completionHandlerForLocations(nil, error)
            } else {
                
                if let result = result?[UdacityParseClient.JSONResponseKeys.Results] as? [[String:AnyObject]] {
                    
                    let locations = StudentInformation.locationsFromResults(result)
                    completionHandlerForLocations(locations, nil)
                } else {
                    completionHandlerForLocations(nil, NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocations"]))
                }
            }
        }
    }
    
    //MARK: POST Convenience Methods
    func postAStudentLocation(newUserMapString: String, newUserMediaURL: String, newUserLatitude: Double, newUserLongitude: Double, completionHandlerForLocationPOST: @escaping (_ success:Bool, _ error:String) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        
        // backslash before the double quote you want to insert in the String
        let jsonBody = "{\"uniqueKey\": \"\(StudentInformation.UserData.uniqueKey)\", \"firstName\": \"\(StudentInformation.UserData.firstName)\", \"lastName\": \"\(StudentInformation.UserData.lastName)\",\"mapString\":  \"\(newUserMapString)\", \"mediaURL\": \"\(newUserMediaURL)\",\"latitude\": \(newUserLatitude), \"longitude\":  \(newUserLongitude)}"
        
        print("jsonBody for POST: \(jsonBody)")
        
        /* 2. Make the request */
        let _ = taskForPOSTAStudentLocation(jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForLocationPOST(false, "Error: Could not POST new user location")
                print(error)
                
                print("POST Error?: \(error)")
            } else {
                completionHandlerForLocationPOST(true, "Successful POST")
            }
        }
    }
    
}
