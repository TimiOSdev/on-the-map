//
//  StudentDataFarm.swift
//  onthemap
//
//  Created by Tim McEwan on 11/8/18.
//  Copyright © 2018 sudo. All rights reserved.
//


import Foundation

class StudentDataFarm: NSObject {
    
    static let sharedInstance = StudentDataFarm()
    
    var arrayOfStudentLocations = [StudentInformation]()
    
    
}

