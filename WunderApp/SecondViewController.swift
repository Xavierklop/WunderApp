//
//  SecondViewController.swift
//  WunderApp
//
//  Created by Hao Wu on 2018/10/3.
//  Copyright © 2018年 Hao Wu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var cars: [Car] = []
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // set initial location in Hamburg
        let initialLocation = CLLocation(latitude: 53.59345, longitude: 10.07534)
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        mapView.register(CarView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        loadInitialData()
        mapView.addAnnotations(cars)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        
        
    }

    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func loadInitialData() {
        guard let fileName = Bundle.main.path(forResource: "locations", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let dictionary = json as? [String: Any],
            let works = dictionary["placemarks"] as? [[String: Any]]
            else { return }
        
        let validWorks = works.compactMap { Car(json: $0) }
        
        cars = validWorks
    }
    
}

extension SecondViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Car
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        for annotation in mapView.annotations {
            let otherView = mapView.view(for: annotation)
            
            if otherView?.isHidden == true {
                otherView?.isHidden = false
//                view.canShowCallout = false
            } else {
                otherView?.isHidden = true
//                view.canShowCallout = true
            }
        }
        
        view.isHidden = false
    }
    
}

extension SecondViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: userLocation, span: span)

        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
    }
}

