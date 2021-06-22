//
//  LocationViewModel.swift
//  MovieCenter
//
//  Created by Usuario on 22/6/21.
//
import Foundation
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    let geoCoder = CLGeocoder()
//    @Published var  region:String? {
//        willSet {
//            objectWillChange.send()
//        }
//    }
    @Published var  region:String? 
    
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
        geoCoder.reverseGeocodeLocation(currentLocation) { [self] (placemarks, error) in
            guard let currentLocPlacemark = placemarks?.first else { return }
            self.region = currentLocPlacemark.isoCountryCode
       
      
        }
    }
}

 
