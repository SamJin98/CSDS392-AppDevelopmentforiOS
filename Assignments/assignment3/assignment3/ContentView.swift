//
//  ContentView.swift
//  assignment3
//
//  Created by Sam Jin on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = APODViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if let apod = viewModel.apod {
                    VStack {
                        Text("Latest News")
                            .font(.headline)
                        Text(apod.title)
                            .font(.title)
                            .padding()

                        let imageUrlString = apod.hdurl ?? apod.url
                        if let imageUrl = URL(string: imageUrlString) {
                            AsyncImage(url: imageUrl) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity)
                                case .failure:
                                    Text("Failed to load image.")
                                case .empty:
                                    ProgressView()
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }

                        ScrollView {
                            Text(apod.explanation)
                                .font(.body)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                    }
                } else if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    Text("No image available.")
                }

                // Link to past images
                NavigationLink("View Past Images", destination: PastImagesView(viewModel: viewModel))
                    .padding()
            }
            .task {
                await viewModel.fetchToday()
                await viewModel.fetchPastImages()
            }
        }
    }
}



#Preview {
    ContentView()
}
