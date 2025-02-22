//
//  ReminderModel.swift
//  RemindMe
//
//  Created by Brian Krupp on 2/4/25.
//

import Foundation
struct ReminderModel {
    static private func fileURL() -> URL? {
        let manager = FileManager.default
        let documentsDirectory = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentsDirectory?.appendingPathComponent("reminders.json")
        
    }
    static public func save(_ reminders:[Reminder]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(reminders)
            if let fileURL = fileURL() {
                try data.write(to: fileURL, options: [.completeFileProtection, .atomic])
            }
        }
        catch {
            print("Unable to save data \(error)")
        }
        
    }
    static public func load() -> [Reminder] {
        let decoder = JSONDecoder()
        if let fileURL = fileURL(),
           let data = try? Data(contentsOf: fileURL),
           let loadedReminders = try? decoder.decode([Reminder].self, from: data){
            return loadedReminders
        }
        return [Reminder]()
    }
}
