//
//  TwelveHourPickerButtonView.swift
//  Hydration1
//
//  Created by Mariya Niazi on 25/04/1446 AH.
//

import SwiftUI

// View for a 12-hour time picker with AM/PM selection
struct TwelveHourPickerButtonView: View {
    @Binding var startHour: Date // Binding for start hour date from the parent view
    @State private var selectedHour = 1 // Selected hour in 12-hour format
    @State private var selectedMinute = 0 // Selected minute
    @State private var selectedPeriod = "AM" // AM/PM period selection
    @State private var showTimePicker = false // Boolean to toggle time picker sheet
    
    let hours = Array(1...12) // Array of hours in 12-hour format
    let minutes = Array(0..<60) // Array of minutes
    let periods = ["AM", "PM"] // Array of time periods (AM/PM)
    
    var body: some View {
        VStack {
            timePickerButton() // Button to display the current time and open picker
        }
    }
    
    // Button to display and open the time picker in a sheet
    func timePickerButton() -> some View {
        HStack {
            Button(action: {
                showTimePicker.toggle() // Toggle visibility of time picker
            }) {
                Text(formattedTime()) // Display formatted time as button label
                    .font(.system(size: 17, weight: .medium))
                    .padding()
                    .frame(maxWidth: 74, maxHeight: 34, alignment: .trailing)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .cornerRadius(8)
            }
            .padding()
            .sheet(isPresented: $showTimePicker) { // Sheet to display time picker
                timePickerSheet()
            }
            
            // Segmented picker to choose AM or PM
            Picker("AM/PM", selection: $selectedPeriod) {
                ForEach(periods, id: \.self) { period in
                    Text(period).tag(period)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(maxWidth: 100, minHeight: 34)
            .cornerRadius(10)
        }
    }
    
    // Time picker sheet with hour and minute selection
    func timePickerSheet() -> some View {
        VStack {
            HStack {
                // Picker for selecting hour in 12-hour format
                Picker("Select Hour", selection: $selectedHour) {
                    ForEach(hours, id: \.self) { hour in
                        Text("\(hour)").tag(hour)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(minWidth: 28, minHeight: 28, alignment: .trailing)
                .clipped()
                
                // Picker for selecting minute
                Picker("Select Minute", selection: $selectedMinute) {
                    ForEach(minutes, id: \.self) { minute in
                        Text(String(format: "%02d", minute)).tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(minWidth: 28, minHeight: 28, alignment: .trailing)
                .clipped()
            }
            .padding()
            
            // Done button to save selected time and close the picker
            Button("Done") {
                convertTo24HourFormat() // Convert selected time to 24-hour format
                showTimePicker.toggle() // Close the picker
            }
            .padding()
        }
    }
    
    // Converts selected 12-hour format time to 24-hour format and updates startHour
    func convertTo24HourFormat() {
        var hourIn24Format = selectedHour
        if selectedPeriod == "PM" && selectedHour != 12 {
            hourIn24Format += 12 // Convert PM hours (except 12 PM)
        } else if selectedPeriod == "AM" && selectedHour == 12 {
            hourIn24Format = 0 // Convert 12 AM to 0 hours (midnight)
        }
        
        var components = Calendar.current.dateComponents([.year, .month, .day], from: startHour)
        components.hour = hourIn24Format
        components.minute = selectedMinute
        
        // Update startHour with new date and time
        if let newDate = Calendar.current.date(from: components) {
            startHour = newDate
        }
    }
    
    // Formats startHour as a 12-hour time string with hour and minute
    func formattedTime() -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: startHour)
        let hour = components.hour! % 12 == 0 ? 12 : components.hour! % 12 // Adjust for 12-hour display
        let minute = String(format: "%02d", components.minute!) // Format minute with leading zero
        
        return "\(hour):\(minute)"
    }
}
