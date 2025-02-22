//
//  Models.swift
//  assignment2
//
//  Created by Sam Jin on 2/18/25.
//

import Foundation

struct Contact: Identifiable {
    let id = UUID()
    var firstName: String
    var lastName: String
    var image: String?
    var isFavorite: Bool
    var messages: [String]
}
