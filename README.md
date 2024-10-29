## Features

### 1- Onboarding: 
Personalized setup, including input of body weight for calculating daily water goals.
### 2- Water Intake Tracking: 
Track current water intake against a user-defined daily goal.
### 3- Notifications: 
Customizable reminders with start/end times and intervals to keep users hydrated.
### 4- Alerts and Progress Feedback: 
Motivational alerts when halfway or near the daily hydration goal.
### 5- Persistence: 
Saves preferences and data locally using UserDefaults.


## Screenshots


<img width="426" alt="Screenshot 1446-04-26 at 10 40 58 AM" src="https://github.com/user-attachments/assets/bbc8ad84-153e-464e-b5e5-f43209ba0783">
<img width="426" alt="Screenshot 1446-04-26 at 10 41 42 AM" src="https://github.com/user-attachments/assets/4c29bd01-f2bf-4df6-b5dd-be9ccc3cf111">
<img width="426" alt="Screenshot 1446-04-26 at 10 41 51 AM" src="https://github.com/user-attachments/assets/a26cbd9a-fdb6-45a1-9560-1783bfd5cacc">
<img width="426" alt="Screenshot 1446-04-26 at 10 42 10 AM" src="https://github.com/user-attachments/assets/4eb234f1-f810-4324-a6b4-54d21db7c02b">
<img width="426" alt="Screenshot 1446-04-26 at 10 42 25 AM" src="https://github.com/user-attachments/assets/2da4103c-3226-4bce-ab47-bfa28cda3ea1">
<img width="426" alt="Screenshot 1446-04-26 at 10 42 37 AM" src="https://github.com/user-attachments/assets/c93fdb9f-8d40-4da6-ba51-36ea1fcae055">
<img width="426" alt="Screenshot 1446-04-26 at 10 42 41 AM" src="https://github.com/user-attachments/assets/b8b7757a-76e0-4bf7-ba09-2bd1ae409d66">
<img width="426" alt="Screenshot 1446-04-26 at 10 42 55 AM" src="https://github.com/user-attachments/assets/6a8b76bb-d46d-468f-8eab-a5f9fafaa720">

## Installation

Clone the repository:
bash
Copy code
git clone https://github.com/yourusername/Hydration1.git
Open the project in Xcode: Open Hydration1.xcodeproj in Xcode.
Build and run: Select your target device/simulator, and click Run.

## Code Overview

### Key Components

### 1- OnboardingView:
Allows users to input body weight for calculating a personalized daily water goal.
### 2- WaterIntakeView:
Displays the current water intake as a progress circle.
Allows for incrementing/decrementing water intake using a Stepper.
Triggers motivational alerts based on intake milestones.
NotificationPreferencesView:
Manages notification settings for hydration reminders.
Includes start/end time pickers and interval options.
View Models
### 3- OnboardingViewModel:
Manages the logic for calculating and saving the daily water intake goal based on user’s body weight.
### 4- WaterIntakeViewModel:
Tracks the user’s water intake progress and manages alerts based on progress milestones.
### 5- NotificationPreferencesViewModel:
Handles saving and scheduling notifications for hydration reminders, ensuring users stay notified within set intervals.







