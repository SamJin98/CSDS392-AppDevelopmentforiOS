//
//  APODDetailView.swift
//  assignment3
//
//  Created by Sam Jin on 3/3/25.
//
import SwiftUI


struct APODDetailView: View {
    let apod: APOD
    
    var body: some View {
        VStack {
            Text(apod.title).font(.title).padding()
            AsyncImage(url: URL(string: apod.url)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().aspectRatio(contentMode: .fit).frame(maxWidth: .infinity)
                case .failure(_):
                    Text("Failed to load image")
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            ScrollView{
                Text(apod.explanation)
                    .font(.body)
                    .padding(.horizontal)
            }
            Spacer()
        }
        .navigationTitle(apod.date)
    }
}
