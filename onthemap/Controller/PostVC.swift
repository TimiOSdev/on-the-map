//
//  PostVC.swift
//  onthemap
//
//  Created by Tim McEwan on 11/4/18.
//  Copyright © 2018 sudo. All rights reserved.
//

import UIKit

import MapKit
import CoreLocation

class PostVC: UIViewController, UIGestureRecognizerDelegate {
    //Outlets
    @IBOutlet weak var firstNameTextOut: UITextField!
    @IBOutlet weak var lastNameTextOut: UITextField!
    @IBOutlet weak var shareURLTextOutlet: UITextField!
    
    var lat:Double?
    var long: Double?
    var newLocation = StudentInformation.NewUserLocation.mapString
    var newURL = StudentInformation.NewUserLocation.mediaURL
    var userObjectId = StudentInformation.NewUserLocation.mediaURL
    var studentInformation: [StudentInformation] = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: ROLL TIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let thisLat = self.lat {
            print(thisLat)
            lat = thisLat
        }
        if let thisLong = self.long {
            long = thisLong
            print(thisLong)
        }
        
      let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat ?? 0.00, longitude: long ?? 0.00)
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func userNewLocationData() -> [[String : Any]] {
        return [
            [
                "createdAt" : "",
                "firstName" : StudentInformation.UserData.firstName,
                "lastName" : StudentInformation.UserData.lastName,
                "latitude" : StudentInformation.NewUserLocation.latitude,
                "longitude" : StudentInformation.NewUserLocation.longitude,
                "mapString" : StudentInformation.NewUserLocation.mapString,
                "mediaURL" : StudentInformation.NewUserLocation.mediaURL,
                "objectId" : "",
                "uniqueKey" : StudentInformation.UserData.uniqueKey,
                "updatedAt" : ""
            ]
        ]
    }
    
    //MARK: Actions
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        StudentInformation.UserData.firstName = firstNameTextOut.text ?? "JOE"
        StudentInformation.UserData.lastName = lastNameTextOut.text ?? "COOL"
        //Get Student's Data
        if userObjectId.isEmpty {
            callPostToStudentLocation()
            let controller = storyboard!.instantiateViewController(withIdentifier: "PinMapController") 
            present(controller, animated: true, completion: nil)
        } else {
            self.showAlert(problem: "Failed", solution: "Failed to post user info")
        }
    }
    func showAlert(problem: String, solution: String)  {
        let alert = UIAlertController(title: problem, message: solution, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    //MARK: Methods
    func callPostToStudentLocation() {
        UdacityParseClient.sharedInstance().postAStudentLocation(newUserMapString: self.newLocation, newUserMediaURL: shareURLTextOutlet.text ?? "http://www.google.com", newUserLatitude: self.lat ?? 0.00, newUserLongitude: self.long ?? 0.00) { (success, errorString) in
print(success)
}
}
}
