//
//  ContentView.swift
//  xkcd
//
//  Created by Sam Jin on 2/11/25.
//

import SwiftUI

struct XKCDComic : Codable {
    var num:Int
    var month:String
    var day:String
    var year:String
    var title:String
    var img:String
    var alt:String
}

@Observable
class ComicModel {
    var comic: XKCDComic?
    var imageURL: URL?
    var refreshDate: Date?
    
    func refresh() async {
        self.comic = await getComic()
    }
    private func getComic() async -> XKCDComic? {
        let session = URLSession(configuration: .default)
        if let url = URL(string: "https://xkcd.com/info.0.json") {
            let request = URLRequest(url: url)
            do {
                let (data, _) = try await session.data(for: request)
                let decoder = JSONDecoder()
                let comic = try decoder.decode(XKCDComic.self, from: data)
                self.imageURL = URL(string: comic.img)
                self.refreshDate = Date()
                return comic
            }
            catch {
                
            }
        }
        return nil
    }
}


struct ContentView: View {
    @State var fetchingComic = false
    @State var comicModel = ComicModel()
    
    func loadComic() {
        fetchingComic = true
        Task {
            await comicModel.refresh()
            fetchingComic = false
        }
    }
    
    var body: some View {
        VStack {
            Text("Today's XKCD Comic")
                .font(.title)
            Text(comicModel.comic?.title ?? "")
            AsyncImage(url:comicModel.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode:.fit)
            } placeholder: {
                if fetchingComic {
                    ProgressView()
                }
            }
            Spacer()
            Button("Get Comic") {
                loadComic()
            }
            .disabled(fetchingComic)
        }
        .padding()
        .onAppear {
            loadComic()
        }
    }
}

#Preview {
    ContentView()
}
