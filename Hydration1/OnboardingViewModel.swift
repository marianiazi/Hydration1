//
//  OnboardingViewModel.swift
//  Hydration1
//
//  Created by Mariya Niazi on 25/04/1446 AH.
//

import SwiftUI

// ViewModel for handling logic related to the onboarding process
class OnboardingViewModel: ObservableObject {
    @Published var bodyWeight: String = "" // Stores user's input for body weight
    @Published var isNextScreenActive = false // Controls navigation to the next screen
    
    // Calculates daily water intake based on the user's weight
    func calculateDailyWaterIntake(_ weight: Double) -> Double {
        return weight * 0.03 // Daily intake in liters is 3% of body weight
    }
    
    // Saves the calculated daily water intake to UserDefaults
    func saveWaterIntake() {
        if let weight = Double(bodyWeight) { // Converts weight input to Double
            let waterIntake = calculateDailyWaterIntake(weight) // Calculates intake
            UserDefaults.standard.set(waterIntake, forKey: "dailyWaterIntake") // Saves intake to UserDefaults
            print("Daily water intake saved: \(waterIntake) liters") // Debug message
            isNextScreenActive = true // Activates navigation to next screen
        } else {
            print("Invalid weight input") // Debug message for invalid input
        }
    }
}
