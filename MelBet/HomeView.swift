//
//  HomeView.swift
//  Dafabet
//
//  Created by Кирилл Архипов on 11.07.2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userService: UserService
    @Binding var searchText: String

    private var filteredMatches: [MatchModel] {
            if searchText.isEmpty {
                return userService.matches
            } else {
                return userService.matches.filter { match in
                    match.name.localizedCaseInsensitiveContains(searchText) ||
                    match.location.localizedCaseInsensitiveContains(searchText) ||
                    match.weather.localizedCaseInsensitiveContains(searchText) ||
                    match.xg.localizedCaseInsensitiveContains(searchText)
                }
            }
        }

    var body: some View {
        ZStack {
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Home")
                        .foregroundStyle(.yellowMain)
                        .font(.system(size: 24, weight: .bold))
                        .padding(.bottom, 30)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ForEach (filteredMatches) { match in
                        MatchPreView(match: match)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
                .padding(.bottom, getSafeAreaBottom())
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            userService.match = nil
                            userService.isAddingMatch = true
                        }
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.black)
                            .padding()
                            .background(
                                Circle()
                                    .fill(.yellowMain)
                            )
                            .frame(height: 50)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 120)
                .padding(.bottom, getSafeAreaBottom())
            }
        }
    }
}

#Preview {
    HomeView(searchText: .constant(""))
        .environmentObject(UserService())
}
