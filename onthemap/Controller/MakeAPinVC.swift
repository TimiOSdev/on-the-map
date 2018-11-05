//
//  MakeAPinVC.swift
//  onthemap
//
//  Created by Tim McEwan on 11/4/18.
//  Copyright © 2018 sudo. All rights reserved.
//
import UIKit
import MapKit

class MakeAPinVC: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var locationText: UITextField!

    var newLocation = ""
    var newURL = ""
    var newLatitude = 0.0
    var newLongitude = 0.0
    var coordinates = [CLLocationCoordinate2D]() {
        didSet {
            
            for (_, coordinate) in self.coordinates.enumerated() {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
            }
        }
    }
    
    //MARK: Actions
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        locationText.text = ""
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationButtonTapped(_ sender: UIButton) {
        guard let location = locationText.text, location != "" else {
            //TODO : make an alert for Error message
            return
        }
   
        
//        guard let url = enterURLTextField.text, url != "", url.hasPrefix("https://") else {
//            print("URL is empty")
//            //TODO:  Create Alert for error message
//            return
//        }
        
//        self.disableUI()
//
        StudentInformation.NewUserLocation.mapString = location
        newLocation = location
//        StudentInformation.NewUserLocation.mediaURL = url
//        newURL = url
        
        getCoordinatesFromLocation(location: newLocation)
    }
    
    //MARK: Methods
    
    func getCoordinatesFromLocation(location: String) {
        print("getCoordinatesOfLocation called")
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(location) {
            (placemarks, error) in
            // No internet connection
            print("getCoordinatesFromLocation error \(String(describing: error))")
            
            guard (error == nil) else {
                print("Print Error: \(String(describing: error!.localizedDescription))")
                //Create an alert for connection and error
                return
            }
            
            let placemark = placemarks?.first
            
            guard let placemarkLatitude = placemark?.location?.coordinate.latitude else {
                print("Could not calculate latitude coordinate from geocodeAddressString")
               //Could not calculate location
                return
            }
            
            StudentInformation.NewUserLocation.latitude = placemarkLatitude
            
            guard let placemarkLongitude = placemark?.location?.coordinate.longitude else {
                print("Could not calculate longitude coordinate from geocodeAdressString")
                return
            }
            
            StudentInformation.NewUserLocation.longitude = placemarkLongitude
//
            print("geCoordinatesOfLocation: Lat: \(StudentInformation.NewUserLocation.latitude), Lon: \(StudentInformation.NewUserLocation.longitude)")
            
            print("Call passDataToNextViewController")
            self.passDataToNextViewController()
        }
    }
    
    func passDataToNextViewController() {
        print("Confirmed")
        
        performUIUpdatesOnMain {
            let addLocationMapVC = self.storyboard?.instantiateViewController(withIdentifier: "toConfirmPin") as! PostVC
            addLocationMapVC.lat = StudentInformation.NewUserLocation.latitude as Double
            addLocationMapVC.long = StudentInformation.NewUserLocation.longitude as Double
            self.navigationController?.pushViewController(addLocationMapVC, animated: true)
        }
    }
}
