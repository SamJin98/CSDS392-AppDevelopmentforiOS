//
//  APODViewModel.swift
//  assignment3
//
//  Created by Sam Jin on 3/3/25.
//


import SwiftUI

class APODViewModel: ObservableObject {
    @Published var apod: APOD?
    @Published var pastImages: [APOD] = []
    @Published var isLoading = false

    private let service = APODService()

    func fetchToday() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let result = try await service.fetchAPOD()
            if result.mediaType == "image" {
                apod = result
            }
        } catch {
            print("Failed to fetch today's APOD: \(error)")
        }
    }

    func fetchPastImages() async {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calendar = Calendar.current
        var dates: [String] = []
        
        for dayOffset in 1...6 {
            if let date = calendar.date(byAdding: .day, value: -dayOffset, to: Date()) {
                dates.append(dateFormatter.string(from: date))
            }
        }

        for date in dates {
            do {
                let apod = try await service.fetchAPOD(for: date)
                if apod.mediaType == "image" {
                    DispatchQueue.main.async {
                        self.pastImages.append(apod)
                    }
                }
            } catch {
                print("Failed to fetch APOD for \(date): \(error)")
            }
        }
    }
}
