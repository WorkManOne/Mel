//
//  AnalysisView.swift
//  Mel
//
//  Created by Кирилл Архипов on 24.07.2025.
//

import SwiftUI

struct AnalysisView: View {
    @EnvironmentObject var userService: UserService
    @State private var isSavedFilter: Bool = false

    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                HStack {
                    Text("Analysis")
                        .foregroundStyle(.yellowMain)
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                    Button {
                        withAnimation {
                            isSavedFilter.toggle()
                        }
                    } label: {
                        Image(isSavedFilter ? "saved_yellow" : "saved_white")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(.bottom, 30)
                ForEach (userService.matches.filter { $0.isSaved == isSavedFilter } ) { match in
                    if isSavedFilter {
                        MatchPreView(isAnalyzed: true, match: match)
                    } else {
                        Button {
                            withAnimation {
                                if userService.match?.id == match.id {
                                    userService.match = nil
                                } else {
                                    userService.match = match
                                }
                            }
                        } label: {
                            HStack {
                                Text(match.name)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(userService.match?.id == match.id ? .black : .white)
                                Spacer()
                                if userService.match?.id != match.id {
                                    Button {
                                        withAnimation {
                                            if let index = userService.matches.firstIndex(where: { $0.id == match.id }) {
                                                userService.matches.remove(at: index)
                                            }
                                        }
                                    } label: {
                                        Image(systemName: "minus")
                                            .foregroundStyle(.black)
                                            .font(.system(size: 12))
                                            .padding(8)
                                            .background {
                                                Circle()
                                                    .fill(.white)
                                            }
                                    }
                                }
                            }
                            .colorFramed(color: userService.match?.id == match.id ? .yellowMain : .darkFrame)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
            .padding(.bottom, getSafeAreaBottom())
        }
    }
}

#Preview {
    AnalysisView()
        .environmentObject(UserService())
        .background(
            .black
        )
}
