//
//  OnboardingView.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var userService: UserService
    @State private var selectedIndex = 0

    var body: some View {
        VStack {
            Spacer()
            Image("analysis_fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            Text("Welcome to Mel")
                .foregroundStyle(.white)
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.vertical)
            Text("Track past football matches, create your own analysis plan, and get smart insights with AI.")
                .foregroundStyle(.lightText)
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
            Button {
                userService.isFirstLaunch = false
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.black)
                    .font(.system(size: 30))
                    .padding(20)
                    .background(
                        Circle()
                            .fill(.yellowMain)
                    )
            }
            .padding(.bottom, 30)
        }
        .background(.darkFrame)
    }
}

#Preview {
    OnboardingView()
        .background(.black)
        .environmentObject(UserService())
}
