//
//  LocationModel.swift
//  FindMe
//
//  Created by Sam Jin on 3/22/25.
//

import Foundation
import CoreLocation

class LocationModel : LocationManagerDelegate {
    var locations = [CLLocation]()
    
    func didUpdateLocation(_ location: CLLocation) {
        self.locations.append(location)
        print("\(location)")
    }
}
