//
//  MelBetApp.swift
//  MelBet
//
//  Created by Кирилл Архипов on 23.07.2025.
//

import SwiftUI

@main
struct MelApp: App {
    @ObservedObject var userService = UserService()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userService)
                .preferredColorScheme(.dark)
                .fullScreenCover(isPresented: .constant(userService.isFirstLaunch)) {
                    OnboardingView()
                        .environmentObject(userService)
                }
        }
    }
}
