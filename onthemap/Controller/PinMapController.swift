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
    
    var lat:Double?
    var long: Double?
    var creationDate: Date?
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 10000
    var selectedPin:MKAnnotation?
    var studentInformation: [StudentInformation] = []
    
    //MARK: CONNECTION OUTLETS
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: ROLL TIDE
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UdacityParseClient.sharedInstance().getStudentLocations {[weak self] (students, error) in
            if students == nil {
                self?.showAlert(problem: "Failure to load pins", solution: "Please make sure WiFi or internet is on")
                return
            }
            guard let self = self else { return }
            guard let students = students else {
                
                return
            }

            for student in students {

                self.studentInformation.append(contentsOf: [student])
                performUIUpdatesOnMain {
                    self.infoLabel.text = "Loading"
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: student.latitude ?? 0, longitude: student.longitude ?? 0)
                    annotation.subtitle = "\(student.firstName ?? "JOE") \(student.lastName ?? "Cool")"
                    annotation.title = student.mediaURL ?? ""
                    
                    self.mapView.addAnnotation(annotation)
                    self.mapView.reloadInputViews()
                }
            }
            self.infoLabel.text = "Done"
            let secondTab = self.tabBarController?.viewControllers?[1] as! TableVC
            secondTab.studentInfo = self.studentInformation
            
        }
        self.navigationItem.leftBarButtonItem?.title = "LogOut"
        self.navigationItem.rightBarButtonItem?.title = "Edit"

    }

    
    
    
    ////////////////////////////////////////////////////////////////////////////
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        if let url = URL(string: (((view.annotation?.title)!) ?? "https://www.google.com")) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    
    @IBAction func logOut(_ sender: Any) {
       UdacityParseClient.sharedInstance().taskForDELETELogoutMethod()

        let controller = storyboard!.instantiateViewController(withIdentifier: "loginNow") 
        present(controller, animated: true, completion: nil)
}
}

extension PinMapController: MKMapViewDelegate{
    //This will center users on the map
    func centerMapOnUserLocation() {
        
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    //MARK: OBJC objects
    @objc func dropPin(sender: UITapGestureRecognizer) {
        //Drop pin on the map
        if isEditing == false {
            if sender.state == UIGestureRecognizer.State.began {
                let annotation = MKPointAnnotation()
                let touchPoint = sender.location(in: mapView)
                print(touchPoint)
                let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                print("This is the map gps coordinate\(touchCoordinate)")
                annotation.coordinate = CLLocationCoordinate2D(latitude: touchCoordinate.latitude , longitude: touchCoordinate.longitude)
                mapView.addAnnotation(annotation)
            }
            
        }
        
    }
    
    func showAlert(problem: String, solution: String)  {
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

