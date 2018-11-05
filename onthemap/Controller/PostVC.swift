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
    
    var lat:Double?
    var long: Double?
    var creationDate: Date?
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000000
    var selectedPin:MKAnnotation?
    var studentInformation: [StudentInformation] = []
    
    //MARK: CONNECTION OUTLETS
    

    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: ROLL TIDE
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mapView.delegate = self
//        locationManager.delegate = self
//        configureLocationServices()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    

}

extension PostVC: MKMapViewDelegate{
    //This will center users on the map
//    func centerMapOnUserLocation() {
//
//        guard let coordinate = locationManager.location?.coordinate else { return }
//        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
//        mapView.setRegion(coordinateRegion, animated: true)
//    }
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

