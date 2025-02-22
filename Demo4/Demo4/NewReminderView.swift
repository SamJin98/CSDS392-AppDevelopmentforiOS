//
//  NewReminderView.swift
//  RemindMe
//
//  Created by Brian Krupp on 1/28/25.
//

import SwiftUI

struct NewReminderView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var reminder:Reminder
    @Binding var reminders:[Reminder]
    var isUpdating:Bool
    var body: some View {
        VStack {
            if !isUpdating {
                HStack {
                    Text("New Reminder")
                        .font(.title2)
                    Spacer()
                }
            }
            TextField("Title", text:$reminder.title)
            TextField("Notes", text:$reminder.notes, axis: .vertical)
                .lineLimit(3...10)
            Picker("Priority", selection: $reminder.priority) {
                ForEach(Priority.allCases) { priority in
                    Text(priority.rawValue)
                }
            }
            .pickerStyle(.segmented)
            Spacer()
            if !isUpdating {
                Button("Save") {
                    // What do we do?
                    reminders.append(reminder)
                    ReminderModel.save(reminders)
                    reminder = Reminder(title: "", priority: .low, notes: "")
                    dismiss()
                }
            }
        }
        .onDisappear {
            ReminderModel.save(reminders)
        }
        .padding()
        .navigationTitle(isUpdating ? "Update Reminder" : "New Reminder")
    }
}


#Preview {
    @Previewable @State var reminder: Reminder = Reminder(title: "Jog", priority: .high, notes: "Get new shoes")
    @Previewable @State var reminders: [Reminder] = []
    
    
    NewReminderView(reminder:  $reminder, reminders: $reminders, isUpdating: true)
    
}
