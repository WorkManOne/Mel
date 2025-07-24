//
//  ContentView.swift
//  MelBet
//
//  Created by Кирилл Архипов on 23.07.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userService: UserService
    @State private var selectedTab = 0
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                    }
                }
                TabView (selection: $selectedTab) {
                    HomeView(searchText: $searchText)
                        .tag(0)
                    AnalysisView()
                        .tag(1)
                    SettingsView()
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                VStack (spacing: 0) {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab, searchText: $searchText)
                        .animation(.default, value: selectedTab)
                }
            }
            .background(
                ZStack {
                    Color.black
                    Image("backgroundMain")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .scaleEffect(1.2)
            )
            .blur(radius: userService.isAddingMatch || userService.isShowingAnalyzing ? 10 : 0)
            .ignoresSafeArea()
            if userService.isAddingMatch {
                EditMatchView()
                    .transition(.opacity)
            }
            if userService.isShowingAnalyzing {
                AnalyzingView()
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserService())
}
