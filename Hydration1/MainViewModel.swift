//
//  MainViewModel.swift
//  Hydration1
//
//  Created by Mariya Niazi on 25/04/1446 AH.
//


import SwiftUI

class MainViewModel: ObservableObject {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
}
