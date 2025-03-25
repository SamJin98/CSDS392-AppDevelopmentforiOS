//
//  APODService.swift
//  assignment3
//
//  Created by Sam Jin on 3/3/25.
//


import Foundation

class APODService {
    let baseURL = "https://api.nasa.gov/planetary/apod"
    let apiKey = "HIvGFEqHEC6bqPdvYlmGMGSQYzm4L77JmQBNNb0O"

    func fetchAPOD(for date: String? = nil) async throws -> APOD {
        var urlString = "\(baseURL)?api_key=\(apiKey)"
        if let date = date {
            urlString += "&date=\(date)"
        }
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let apod = try JSONDecoder().decode(APOD.self, from: data)
        return apod
    }
}
