//
//  MainView.swift
//  Hydration1
//
//  Created by Mariya Niazi on 25/04/1446 AH.
//


import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        if viewModel.hasCompletedOnboarding {
            WaterIntakeView()
        } else {
            OnboardingView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
