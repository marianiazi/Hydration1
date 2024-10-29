//
//  NotificationPreferencesViewModel.swift
//  Hydration1
//
//  Created by Mariya Niazi on 25/04/1446 AH.
//

import SwiftUI
import UserNotifications

// ViewModel to manage notification preferences and scheduling for hydration reminders
class NotificationPreferencesViewModel: ObservableObject {
    @Published var selectedInterval: String = "15 Mins" // User-selected interval for notifications
    @Published var startHour = Date() // Start time for notifications
    @Published var endHour = Date() // End time for notifications
    @Published var isWaterIntakeViewActive = false // Controls navigation to water intake view

    let intervals = ["15 Mins", "30 Mins", "60 Mins", "90 Mins", "2 Hours", "3 Hours", "4 Hours", "5 Hours"] // Available intervals for notifications

    // Saves user preferences (start time, end time, interval) to UserDefaults
    func saveNotificationPreferences() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short

        let startHourString = formatter.string(from: startHour) // Formats start hour
        let endHourString = formatter.string(from: endHour) // Formats end hour
        
        UserDefaults.standard.set(startHourString, forKey: "startHour") // Saves start hour
        UserDefaults.standard.set(endHourString, forKey: "endHour") // Saves end hour
        UserDefaults.standard.set(selectedInterval, forKey: "notificationInterval") // Saves interval
    }

    // Schedules notifications based on user-selected preferences
    func scheduleNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                // Clear any existing notifications before scheduling new ones
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                let intervalMinutes = self.calculateIntervalMinutes() // Converts interval to minutes
                var currentDate = self.startHour // Starts from the selected start hour
                
                // Schedules notifications within the specified time range
                while currentDate < self.endHour {
                    let components = Calendar.current.dateComponents([.hour, .minute], from: currentDate)
                    let content = UNMutableNotificationContent()
                    content.title = "Stay Hydrated!"
                    content.body = "Remember to drink water and stay hydrated."
                    content.sound = UNNotificationSound.default
                    
                    // Sets up notification trigger based on current date components
                    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request) // Adds the notification request
                    
                    // Advances currentDate by the selected interval
                    currentDate = Calendar.current.date(byAdding: .minute, value: intervalMinutes, to: currentDate) ?? currentDate
                }
            } else if let error = error {
                print("Notification permission denied: \(error.localizedDescription)") // Logs error if permission denied
            }
        }
    }

    // Converts the selected interval string to minutes for scheduling
    private func calculateIntervalMinutes() -> Int {
        let parts = selectedInterval.components(separatedBy: " ") // Splits interval into number and unit
        if let value = Int(parts[0]) {
            // Converts hours to minutes if the interval contains "hour"
            return parts[1].lowercased().contains("hour") ? value * 60 : value
        }
        return 15 // Default to 15 minutes if parsing fails
    }
}
