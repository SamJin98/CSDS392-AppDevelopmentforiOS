//
//  APOD.swift
//  assignment3
//
//  Created by Sam Jin on 3/3/25.
//

import Foundation

struct APOD: Codable, Identifiable {
    var id: String { date }
    let date: String
    let title: String
    let explanation: String
    let url: String
    let hdurl: String? 
    let mediaType: String
    
    enum CodingKeys: String, CodingKey {
        case date, title, explanation, url, hdurl
        case mediaType = "media_type"
    }
}

