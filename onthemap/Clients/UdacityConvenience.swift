//
//  UdacityConvenience.swift

import UIKit

extension UdacityClient {
    
    
    func getPublicUserData(_ completionHandlerForUserData: @escaping (_ result: Any?, _ error: NSError?) -> Void) {
    
    let _ = getUserData { (results, error) in
        
        if let error = error {
            completionHandlerForUserData(nil, error)
        } else {
            if let results = results?[UdacityClient.JSONUserKey.user] as? [String:AnyObject] {
             completionHandlerForUserData(results, nil)
            
            } else {
       completionHandlerForUserData(nil, NSError(domain: "getPublicUSerData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse get Pulic User  location data"]))
       }
                
      }
                
   }
            
}
    
    
}
