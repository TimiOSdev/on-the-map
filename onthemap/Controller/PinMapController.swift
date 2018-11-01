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
//MARK: GLOBAL VARIABLES
var isEditing = false
class PinMapController: UIViewController, UIGestureRecognizerDelegate {
    
    var lat:Double?
    var long: Double?
    var creationDate: Date?
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 10000
    var selectedPin:MKAnnotation?
    
    //MARK: CONNECTION OUTLETS

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
        addHoldTap()
        self.navigationItem.rightBarButtonItem?.title = "Edit"
    }
    //MARK: ADD and DELETE Pin and functions
    func addHoldTap() {
        
        //Long gesture will drop the pin
        let singleHold = UILongPressGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        singleHold.minimumPressDuration = 0.8
        singleHold.delaysTouchesBegan = true
        singleHold.delegate = self
        mapView.addGestureRecognizer(singleHold)
    }

    
    ////////////////////////////////////////////////////////////////////////////
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // If selection and not true it will move to PhotoAlbumViewController
        if isEditing == true {
            selectedPin = mapView.selectedAnnotations.first
//            pinRemovalOn(selectedPin)
            mapView.removeAnnotation(selectedPin!)
            
        }else {
            lat = view.annotation?.coordinate.latitude
            long = view.annotation?.coordinate.longitude
            performSegue(withIdentifier: "toPhoto", sender: self)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhoto" {
//            let destinationVC = segue.destination as! PhotoAlbumViewController
//            destinationVC.lat = lat!
//            destinationVC.long = long!
//            destinationVC.dataController = self.dataController
        }
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
