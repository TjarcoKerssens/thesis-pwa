//
//  LocationWatcher.swift
//  ThesisPWA
//
//  Created by Tjarco Kerssens on 30/04/2019.
//  Copyright © 2019 Tjarco Kerssens. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationDelegate {
    func locationUpdated(longitude: Double, latitude: Double)
}

class LocationWatcher: NSObject, CLLocationManagerDelegate{
    var locationManager = CLLocationManager()
    var delegate: LocationDelegate?

    /**
        Starts watching the user location and calls the delegates `locationUpdated` function when a
        new location is available.
     */
    func startWatching(delegate: LocationDelegate){
        self.locationManager.requestAlwaysAuthorization()
        self.delegate = delegate
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValues: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        delegate?.locationUpdated(longitude: locationValues.longitude, latitude: locationValues.latitude)
    }
}
