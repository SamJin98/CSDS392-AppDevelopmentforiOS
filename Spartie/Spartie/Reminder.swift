//
//  ContentView.swift
//  Spartie
//
//  Created by Sam Jin on 1/23/25.
//

import SwiftUI

enum Priority: String, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

struct ReminderModel: Identifiable {
    let id = UUID()
    let title: String
    let notes: String
    let priority: Priority

    static let sampleReminders: [ReminderModel] = [
        ReminderModel(title: "Buy groceries", notes: "Milk, Eggs, Bread", priority: .high),
        ReminderModel(title: "Team Meeting", notes: "Discuss project updates", priority: .medium),
        ReminderModel(title: "Workout", notes: "Go for a 5km run", priority: .low)
    ]
}

struct ReminderRow: View {
    let reminder: ReminderModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(reminder.title)
                .font(.headline)

            Text(reminder.notes)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("Priority: \(reminder.priority.rawValue)")
                .font(.caption)
                .foregroundColor(priorityColor(for: reminder.priority))
        }
        .padding(.vertical, 8)
    }
    
    func priorityColor(for priority: Priority) -> Color {
        switch priority {
        case .high: return .red
        case .medium: return .orange
        case .low: return .green
        }
    }
}

struct RemindersListView: View {
    let reminders: [ReminderModel] = ReminderModel.sampleReminders

    var body: some View {
        NavigationView {
            List(reminders) { reminder in
                ReminderRow(reminder: reminder)
            }
            .navigationTitle("Reminders")
        }
    }
}

#Preview {
    RemindersListView()
}

