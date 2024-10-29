//
//  OnboardingView.swift
//  Hydration1
//

import SwiftUI

// View for the onboarding screen, guiding users through initial setup
struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel() // Observed view model for onboarding logic and data

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                VStack {
                    // Top icon symbolizing water/hydration
                    Image(systemName: "drop.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.cyan) // Cyan color for the icon
                        .padding(.top, 40)
                        .offset(x: -150) // Align icon to the left
                    
                    // Title and description text for the onboarding screen
                    VStack(spacing: 20) {
                        Text("Hydrate")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 40)
                            .offset(x: -20) // Left alignment for title
                        
                        Text("Start with Hydrate to record and track your water intake daily based on your needs and stay hydrated")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.gray) // Gray color for descriptive text
                            .padding(.horizontal, 40)
                            .offset(x: -30) // Left alignment for description
                    }
                    
                    // Input field for user body weight
                    HStack {
                        HStack {
                            Text("Body weight")
                                .font(.body)
                                .foregroundColor(.black) // Label for body weight input
                            
                            TextField("Value", text: $viewModel.bodyWeight) // Text field for weight input
                                .keyboardType(.decimalPad) // Numeric input for weight
                                .padding(.leading, 10)
                                .frame(height: 44)
                                .cornerRadius(10)
                            
                            // Clear button to reset the weight input field
                            Button(action: { viewModel.bodyWeight = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(width: 360, height: 50)
                    .background(Color(.systemGray6)) // Background color for input field
                    
                    Spacer()
                }
                .offset(y: 90) // Offset to align top section

                // Navigation link to next screen (Notification Preferences)
                NavigationLink(destination: NotificationPreferencesView(), isActive: $viewModel.isNextScreenActive) {
                    EmptyView() // Hidden navigation link that activates based on state
                }
                
                // "Next" button to proceed with onboarding
                Button(action: {
                    viewModel.saveWaterIntake() // Save weight data and activate next screen
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(width: 360, height: 50)
                        .background(Color.cyan) // Button color
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 30) // Bottom padding for layout balance
            }
            .navigationBarHidden(true) // Hide navigation bar on onboarding
        }
    }
}

// Preview provider for SwiftUI preview in Xcode
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
