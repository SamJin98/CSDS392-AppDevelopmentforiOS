//
//  LocationManager.swift
//  FindMe
//
//  Created by Sam Jin on 3/22/25.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func didUpdateLocation(_ location: CLLocation)
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    public var delegate: LocationManagerDelegate?
    static let shared = LocationManager()
    
    private override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdating() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            delegate?.didUpdateLocation(location)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("authorization changed: \(manager.authorizationStatus)")
        
        switch(manager.authorizationStatus) {
            case .authorizedWhenInUse:
                print("authorized for when in sue")
            case .notDetermined:
                print("waiting on user")
            case .authorizedAlways:
                print("authorized always")
            default:
                print("not authorized")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
    
}
