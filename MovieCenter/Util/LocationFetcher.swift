//
//  LocationManager.swift
//  MovieCenter
//
//  Created by Usuario on 21/6/21.
//

import Foundation
import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    //var lastKnownLocation: CLLocationCoordinate2D?
    let geoCoder = CLGeocoder()
    var region:String?
    var country:String?
    override init() {
        super.init()
        manager.delegate = self
        start()
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    func Stop(){
        manager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }
      //  lastKnownLocation = currentLocation.coordinate
        geoCoder.reverseGeocodeLocation(currentLocation) { [self] (placemarks, error) in
            guard let currentLocPlacemark = placemarks?.first else { return }
            region = currentLocPlacemark.isoCountryCode
            country = currentLocPlacemark.country
            Stop()
        }
    }
}
