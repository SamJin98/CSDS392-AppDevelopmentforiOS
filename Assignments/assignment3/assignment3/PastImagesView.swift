//
//  PastImagesView.swift
//  assignment3
//
//  Created by Sam Jin on 3/3/25.
//

import SwiftUI

struct PastImagesView: View {
    @ObservedObject var viewModel: APODViewModel

    var body: some View {
        List(viewModel.pastImages) { apod in
            NavigationLink(destination: APODDetailView(apod: apod)) {
                HStack {
                    if apod.mediaType == "image", let thumbnailUrl = URL(string: apod.url) {
                        AsyncImage(url: thumbnailUrl) { phase in
                            switch phase {
                            case .success(let image):
                                image.resizable().frame(width: 100, height: 100).clipped()
                            default:
                                ProgressView()
                            }
                        }
                    } else {
                        Color.gray.frame(width: 100, height: 100)
                    }

                    VStack(alignment: .leading) {
                        Text(apod.title).font(.headline)
                        Text(apod.date).font(.subheadline)
                    }
                }
            }
        }
        .navigationTitle("Past 5 Images")
    }
}
