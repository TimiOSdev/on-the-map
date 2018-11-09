//
//  PinMapController.swift
//  onthemap
//
//  Created by Tim McEwan on 11/1/18.
//  Copyright © 2018 sudo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class PinMapController: UIViewController, UIGestureRecognizerDelegate {
    var studentLocations = StudentDataFarm.sharedInstance.arrayOfStudentLocations
    var lat:Double?
    var long: Double?
    var creationDate: Date?
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 10000
    var selectedPin:MKAnnotation?
    
    //MARK: CONNECTION OUTLETS
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: ROLL TIDE
    override func viewDidLoad() {
        
        super.viewDidLoad()
        UdacityParseClient.sharedInstance().getStudentLocations { (students, error) in
            if students == nil {
                self.showAlert(problem: "Failure to load pins", solution: "Please make sure WiFi or internet is on")
                return
            }
            guard let students = students else {
                return
            }
            self.studentLocations.append(contentsOf: students)
            for student in students {
//                self.studentLocations.append(student)
                performUIUpdatesOnMain {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: student.latitude ?? 0, longitude: student.longitude ?? 0)
                    annotation.title = "\(student.firstName ?? "JOE") \(student.lastName ?? "Cool")"
                    annotation.subtitle = student.mediaURL ?? ""
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if annotation is MKUserLocation {return nil}
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            let calloutButton = UIButton(type: .detailDisclosure)
            pinView!.rightCalloutAccessoryView = calloutButton
            pinView!.sizeToFit()
        }
        else {
            pinView!.annotation = annotation
        }
        
        
        return pinView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let url = URL(string: (view.annotation?.subtitle)! ?? "https://www.google.com") else { return }
        UIApplication.shared.open(url)
    }


@IBAction func addPin(_ sender: Any) {
    performSegue(withIdentifier: "toPinMake", sender: self)
}


@IBAction func logOut(_ sender: Any) {
    UdacityParseClient.sharedInstance().taskForDELETELogoutMethod()
    dismiss(animated: true, completion: nil)
}
}

extension PinMapController: MKMapViewDelegate{
    //This will center users on the map
    func centerMapOnUserLocation() {
        
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    public func showAlert(problem: String, solution: String)  {
        let alert = UIAlertController(title: problem, message: solution, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension PinMapController: CLLocationManagerDelegate {
    func configureLocationServices() {
        
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}

