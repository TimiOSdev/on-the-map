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
    
    @IBOutlet weak var locationText: UITextField!
    
    // Variables
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
    override func viewWillAppear(_ animated: Bool) {
        locationText.text = ""
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        locationText.text = ""
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationButtonTapped(_ sender: UIButton) {
        
        guard let location = locationText.text, location != "" else {
            //TODO : make an alert for Error message
            return
        }
        
        StudentInformation.NewUserLocation.mapString = location
        newLocation = location
        getCoordinatesFromLocation(location: newLocation)
    }
    
    //MARK: Methods
    
    func getCoordinatesFromLocation(location: String) {
        
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
            
            guard let geoLatitude = placemark?.location?.coordinate.latitude else {
                print("Could not calculate latitude coordinate from geocodeAddressString")
                return
            }
            
            StudentInformation.NewUserLocation.latitude = geoLatitude
            
            guard let geoLongitude = placemark?.location?.coordinate.longitude else {
                print("Could not calculate longitude coordinate from geocodeAdressString")
                return
            }
            
            StudentInformation.NewUserLocation.longitude = geoLongitude
            self.passDataToNextViewController()
        }
    }
    
    func passDataToNextViewController() {
        
        performUIUpdatesOnMain {
            let addLocationMapVC = self.storyboard?.instantiateViewController(withIdentifier: "toConfirmPin") as! PostVC
            addLocationMapVC.lat = StudentInformation.NewUserLocation.latitude as Double
            addLocationMapVC.long = StudentInformation.NewUserLocation.longitude as Double
            self.navigationController?.pushViewController(addLocationMapVC, animated: true)
        }
    }
}
