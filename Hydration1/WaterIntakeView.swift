import SwiftUI

// Main view for displaying and managing water intake tracking
struct WaterIntakeView: View {
    @StateObject private var viewModel = WaterIntakeViewModel() // Observed view model for handling water intake data and logic

    var body: some View {
        VStack(spacing: 20) {
            
            // Display of current water intake and daily goal
            VStack {
                Text("Today's Water Intake")
                    .font(.headline)
                    .foregroundColor(.gray) // Headline style with gray color
                
                Text("\(String(format: "%.1f", viewModel.currentIntake)) liter / \(String(format: "%.1f", viewModel.dailyGoal)) liter")
                    .font(.title2)
                    .foregroundColor(viewModel.currentIntake >= viewModel.dailyGoal ? .green : .black) // Green text when goal is reached
            }
            .offset(x: -87, y: -90) // Offsetting the text
            .padding(.top, 20)
            
            // Circular progress indicator for water intake
            ZStack {
                Circle()
                    .stroke(lineWidth: 30)
                    .foregroundColor(Color.gray.opacity(0.3)) // Background circle with light gray color
                
                Circle()
                    .trim(from: 0, to: min(viewModel.currentIntake / viewModel.dailyGoal, 1.0))
                    .stroke(style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.cyan) // Cyan color for the progress
                    .rotationEffect(.degrees(-90)) // Starts progress from the top
                
                // Icon based on current water intake level
                if viewModel.currentIntake == 0 {
                    Image(systemName: "zzz")
                        .font(.system(size: 70))
                        .foregroundColor(.yellow) // "Sleeping" icon when no water intake
                } else if viewModel.currentIntake < viewModel.dailyGoal / 2 {
                    Image(systemName: "tortoise")
                        .font(.system(size: 70))
                        .foregroundColor(.yellow) // Tortoise icon for low progress
                } else if viewModel.currentIntake < viewModel.dailyGoal {
                    Image(systemName: "hare")
                        .font(.system(size: 70))
                        .foregroundColor(.yellow) // Hare icon for nearing the goal
                } else {
                    Image(systemName: "hands.clap")
                        .font(.system(size: 70))
                        .foregroundColor(.yellow) // Celebration icon when goal is achieved
                }
            }
            .frame(width: 300, height: 300) // Fixed frame for circular progress
            
            // Display of the current intake in liters
            Text("\(String(format: "%.1f", viewModel.currentIntake)) L")
                .font(.title2)
                .foregroundColor(.black)
                .bold()
                .offset(y: 90) // Offset below the circle
            
            // Stepper control for adjusting water intake
            Stepper(value: $viewModel.currentIntake, in: 0...viewModel.dailyGoal, step: 0.1) {
                EmptyView() // No label for the stepper
            }
            .onChange(of: viewModel.currentIntake) { _ in
                viewModel.saveCurrentIntake() // Save intake value on change
            }
            .padding(.horizontal, 40)
            .offset(x: -90, y: 90) // Positioning stepper control
        }
        .padding() // Overall padding for the view
        
        // Alert for reaching half of the daily goal
        .alert(isPresented: $viewModel.showTortoiseAlert) {
            Alert(
                title: Text("Great job on staying hydrated!"),
                message: Text("Keep up the good work. Every sip brings you closer to your health goals!"),
                dismissButton: .default(Text("Thanks"), action: {
                    viewModel.showTortoiseAlert = false
                })
            )
        }
        
        // Alert for nearing the daily goal
        .alert(isPresented: $viewModel.showHareAlert) {
            Alert(
                title: Text("You're almost there!"),
                message: Text("Just a few more sips to go to reach today's water goal. You're doing fantastic!"),
                dismissButton: .default(Text("Keep Going"), action: {
                    viewModel.showHareAlert = false
                })
            )
        }
    }
}

// Preview provider for SwiftUI preview in Xcode
struct WaterIntakeView_Previews: PreviewProvider {
    static var previews: some View {
        WaterIntakeView()
    }
}
