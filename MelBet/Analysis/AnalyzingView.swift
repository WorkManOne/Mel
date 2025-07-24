//
//  AnalyzingView.swift
//  Mel
//
//  Created by Кирилл Архипов on 24.07.2025.
//

import SwiftUI

struct AnalyzingView: View {
    @EnvironmentObject var userService: UserService
    @State private var glow = false
    @State private var glowTimer: Timer?

    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                HStack {
                    Button {
                        withAnimation {
                            userService.isShowingAnalyzing = false
                            userService.match = nil
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                    Text("Analysis")
                    Spacer()
                }
                .foregroundStyle(.yellowMain)
                .font(.system(size: 24, weight: .bold))
                HStack {
                    Text(userService.match?.name ?? "")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .colorFramed(color: .yellowMain)
                .shadow(color: userService.isAnalyzing ? .yellowMain.opacity(glow ? 1 : 0) : .yellowMain, radius: 20)
                VStack {
                    HStack {
                        Text("AI Analysis")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                        Spacer()
                        Button {
                            if let match = userService.match {
                                if match.isSaved {
                                    if let index = userService.matches.firstIndex(where: { $0.id == match.id }) {
                                        userService.matches.remove(at: index)
                                        userService.match?.isSaved = false
                                    }
                                } else {
                                    var copy = match
                                    copy.id = UUID()
                                    copy.analysis = userService.analysis
                                    copy.isSaved = true
                                    userService.matches.append(copy)
                                    userService.match = copy
                                }
                            }
                        } label: {
                            Image(userService.match?.isSaved ?? false ? "saved_white" : "saved_stroke")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                        }
                    }
                    if userService.isAnalyzing {
                        ProgressView()
                            .progressViewStyle(.circular)
                    } else {
                        Text(userService.analysis)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.lightText)
                            .multilineTextAlignment(.leading)
                    }
                }
                .darkFramed()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
            .padding(.bottom, getSafeAreaBottom())
        }
        .onChange(of: userService.isAnalyzing) { analyzing in
            if analyzing {
                startGlowing()
            } else {
                stopGlowing()
            }
        }
        .onAppear {
            if userService.isAnalyzing {
                startGlowing()
            }
        }
        .onDisappear {
            stopGlowing()
        }
    }

    private func startGlowing() {
        stopGlowing()
        glow = false
        glowTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 1.0)) {
                glow.toggle()
            }
        }
    }

    private func stopGlowing() {
        glowTimer?.invalidate()
        glowTimer = nil
        glow = false
    }
}

#Preview {
    AnalyzingView()
        .environmentObject(UserService())
}
