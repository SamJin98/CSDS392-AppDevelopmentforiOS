//
//  ServerLocations.swift
//  assignment5-location
//
//  Created by Sam Jin on 4/12/25.
//

import SwiftUI


struct ServerLocations: Codable {
    let locations: [UserLocation]
}

struct UserLocation: Codable, Identifiable {
    let id = UUID()
    let user: String
    let lat: Double
    let lng: Double
    let label: String
    
    enum CodingKeys: String, CodingKey {
        case user, lat, lng, label
    }
}
