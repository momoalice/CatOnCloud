//
//  MapViewController.swift
//  CatOnCloud
//
//  Created by irene on 10/22/17.
//  Copyright © 2017 irene. All rights reserved.
//

import UIKit
import MapKit

class CatMapViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate {
    
    
    
    @IBOutlet weak var theMap: MKMapView!
    
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        let location = locations.last as! CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.theMap.setRegion(region, animated:true)
        
        
    }
    
    
    
}
