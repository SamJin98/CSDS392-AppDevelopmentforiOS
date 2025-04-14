//
//  ContentView.swift
//  assignment5-location
//
//  Created by Sam Jin on 4/12/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.505837, longitude: -81.614750),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    ))
    
    var body: some View {
        VStack {
            Map(position: $cameraPosition) {
                ForEach(locationManager.locations) { loc in
                    Annotation(loc.label, coordinate: CLLocationCoordinate2D(latitude: loc.lat, longitude: loc.lng)) {
                        VStack(spacing: 4) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                                .font(.title2)
                            Text(loc.user)
                                .font(.caption)
                                .bold()
                            Text(loc.label)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        .padding(8)
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    }.annotationTitles(.hidden)
                }
            }
            
            TextField("Label (max 25 chars)", text: $locationManager.labelText)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            // Button to post user location with label
            Button("Post My Location") {
                locationManager.postLocation()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
