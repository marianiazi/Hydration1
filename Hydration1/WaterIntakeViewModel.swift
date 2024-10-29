import SwiftUI

// ViewModel to manage water intake tracking and alerts
class WaterIntakeViewModel: ObservableObject {
    @Published var dailyGoal: Double // User's daily water intake goal in liters
    @Published var currentIntake: Double // Current amount of water intake in liters
    
    @Published var showTortoiseAlert: Bool = false // Alert for half-way to goal
    @Published var showHareAlert: Bool = false // Alert for nearing the goal

    init() {
        // Initialize daily goal from UserDefaults or default value
        self.dailyGoal = UserDefaults.standard.double(forKey: "dailyWaterIntake")
        
        // Initialize current intake from UserDefaults or default to 0.0
        if UserDefaults.standard.object(forKey: "currentIntake") == nil {
            self.currentIntake = 0.0
            UserDefaults.standard.set(self.currentIntake, forKey: "currentIntake") // Store initial value in UserDefaults
        } else {
            self.currentIntake = UserDefaults.standard.double(forKey: "currentIntake")
        }
    }

    // Saves the current intake to UserDefaults and checks for alert conditions
    func saveCurrentIntake() {
        UserDefaults.standard.set(currentIntake, forKey: "currentIntake") // Persist current intake
        checkAlertConditions() // Evaluate if an alert should be shown
    }

    // Checks current intake against daily goal to trigger appropriate alerts
    private func checkAlertConditions() {
        if currentIntake >= dailyGoal / 2 && currentIntake < dailyGoal * 0.75 {
            showTortoiseAlert = true // Alert when halfway to 75% of goal
        } else if currentIntake >= dailyGoal * 0.75 && currentIntake < dailyGoal {
            showHareAlert = true // Alert when between 75% and goal
        }
    }
}
