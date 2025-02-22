//
//  ContactRow.swift
//  assignment2
//
//  Created by Sam Jin on 2/18/25.
//

import SwiftUI

struct ContactRow: View {
    let contact: Contact
    
    var body: some View {
        HStack {
            Image(contact.image ?? "default")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(contact.firstName).font(.headline)
                Text(contact.lastName).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
            if contact.isFavorite {
                Image(systemName: "star.fill").foregroundColor(.yellow)
            }
        }
        .padding(.vertical, 5)
    }
}



