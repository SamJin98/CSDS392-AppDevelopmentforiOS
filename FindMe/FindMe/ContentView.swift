//
//  ContentView.swift
//  FindMe
//
//  Created by Sam Jin on 3/22/25.
//

import SwiftUI

struct ContentView: View {
    private let locationManager = LocationManager.shared
    private let locationModel = LocationModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            locationManager.delegate = locationModel
            locationManager.requestPermission()
            locationManager.startUpdating()
        }
    }
}

#Preview {
    ContentView()
}
