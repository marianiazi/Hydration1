//
//  NotificationPreferencesView.swift
//  Hydration1
//
//  Created by Mariya Niazi on 25/04/1446 AH.
//

import SwiftUI

// Main view for managing notification preferences in the Hydration app
struct NotificationPreferencesView: View {
    @StateObject private var viewModel = NotificationPreferencesViewModel() // Observed view model for handling notification preferences logic

    var body: some View {
        VStack(spacing: 20) {
            
            // Header title for the preferences view
            Text("Notification Preferences")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .offset(x: -35) // Left alignment offset
            
            // Subtitle for start and end hour section
            Text("The start and End hour")
                .font(.headline)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .offset(x: -70, y: 10) // Aligning for visual consistency
            
            // Description text for time interval settings
            Text("Specify the start and end date to receive the notifications")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 40)
                .offset(x: -20)
            
            // Start and end hour selection section
            VStack(spacing: -25) {
                HStack {
                    Text("Start hour") // Label for start hour picker
                    TwelveHourPickerButtonView(startHour: $viewModel.startHour) // Custom picker for start hour
                }
                .padding(.horizontal)
                
                HStack {
                    Text("End hour") // Label for end hour picker
                    TwelveHourPickerButtonView(startHour: $viewModel.endHour) // Custom picker for end hour
                }
            }
            .background(Color(.systemGray6)) // Background color for the time picker section
            .padding(.horizontal)
            
            // Notification interval section
            VStack {
                Text("Notification interval")
                    .font(.headline)
                    .foregroundColor(.black)
                    .offset(x: -80, y: -10) // Align label for clarity
                
                Text("How often would you like to receive notifications within the specified time interval")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .offset(x: -20)
                    .padding(.horizontal, 40)
                
                // Grid layout for interval selection buttons
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 4), spacing: 20) {
                    ForEach(viewModel.intervals, id: \.self) { interval in
                        Button(action: { viewModel.selectedInterval = interval }) {
                            let parts = interval.components(separatedBy: " ") // Split interval string into numeric and unit parts
                            if parts.count == 2 {
                                HStack(spacing: 2) {
                                    Text(parts[0]) // Display interval number
                                        .font(.headline)
                                        .foregroundColor(viewModel.selectedInterval == interval ? .white : .blue2)
                                    Text(parts[1]) // Display interval unit
                                        .font(.subheadline)
                                        .foregroundColor(viewModel.selectedInterval == interval ? .white : .gray)
                                }
                                .frame(width: 80, height: 70)
                                .background(viewModel.selectedInterval == interval ? Color.blue2 : Color(.systemGray6)) // Highlight selected interval
                                .cornerRadius(15) // Rounded corners for interval buttons
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .offset(y: 20) // Offset for layout balance
            
            // Navigation link to WaterIntakeView
            NavigationLink(destination: WaterIntakeView(), isActive: $viewModel.isWaterIntakeViewActive) {
                EmptyView() // Hidden navigation link that triggers based on state
            }
            
            // Button to save preferences and start the app's main functionality
            Button(action: {
                viewModel.saveNotificationPreferences() // Save user's notification preferences
                viewModel.scheduleNotifications() // Schedule notifications based on preferences
                UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding") // Set onboarding completion flag
                viewModel.isWaterIntakeViewActive = true // Activate navigation to main view
            }) {
                Text("Start")
                    .font(.callout)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(width: 360, height: 50)
                    .background(Color.blue2) // Background color for the button
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
            .offset(y: 25) // Offset for button alignment
            
            Spacer() // Spacer to push content to the top
        }
        .padding(.top, 10) // Top padding for overall view
    }
}

// Preview provider for SwiftUI preview in Xcode
struct NotificationPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPreferencesView()
    }
}

