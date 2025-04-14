//
//  LocationManager.swift
//  assignment5-location
//
//  Created by Sam Jin on 4/12/25.
//

import SwiftUI
import MapKit

class LocationManager: ObservableObject {
    @Published var locations: [UserLocation] = []
    
    @Published var labelText: String = ""

    private let userId = "rxj420"
    private let userPass = 3642847
    private let baseURL = "https://caslab.case.edu/392/map.php"
    
    init() {
        fetchLocations()
        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            self.fetchLocations()
        }
    }
    
    // MARK: - Fetch (GET) Locations
    func fetchLocations() {
        guard let url = URL(string: baseURL) else { return }
        print("Requesting all locations from: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            if let respString = String(data: data, encoding: .utf8) {
                print("Received response:\n\(respString)")
            }
            
            if let decoded = try? JSONDecoder().decode(ServerLocations.self, from: data) {
                DispatchQueue.main.async {
                    self.locations = decoded.locations
                }
            }
        }.resume()
    }
    
    // MARK: - Post (POST) Location
    func postLocation() {
        guard let url = URL(string: baseURL) else { return }
        
        let body: [String: Any] = [
            "user": userId,
            "pass": userPass,
            "lat": 41.505847,
            "lng": -81.618413,
            "label": labelText
        ]
        
        print("Sending request: \(body)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            if let respString = String(data: data, encoding: .utf8) {
                print("Received:\n\(respString)")
            }
            
            self.fetchLocations()
        }.resume()
    }
}
