//
//  CustomTabBar.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import SwiftUI

func getSafeAreaBottom() -> CGFloat {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else {
        return 44
    }
    return window.safeAreaInsets.bottom
}

struct CustomTabBar: View {
    @EnvironmentObject var userService: UserService
    @Binding var selectedTab: Int
    @Binding var searchText: String

    var body: some View {
        VStack {
            if selectedTab == 0 {
                HStack {
                    Image("search")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                    TextField("Search", text: $searchText, prompt: Text("Search").foregroundColor(.lightText))
                }
                .darkFramed()
                .padding(.horizontal, 20)
                .transition(.asymmetric(insertion: .push(from: .top), removal: .push(from: .bottom)))
            }
            if selectedTab == 1 {
                Button {
                    withAnimation {
                        guard let match = userService.match else { return }
                        userService.isShowingAnalyzing = true
                        userService.isAnalyzing = true
                        GPTService().generateMatchAnalysis(from: match) { analysis in
                            DispatchQueue.main.async {
                                userService.analysis = analysis ?? ""
                                userService.isAnalyzing = false
                            }
                        }
                    }
                } label: {
                    Text("Analyze")
                        .foregroundStyle(.black)
                        .font(.system(size: 16))
                        .padding()
                        .padding(1)
                        .background {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(.yellowMain)
                        }
                }
                .transition(.asymmetric(insertion: .push(from: .top), removal: .push(from: .bottom)))
            }
            HStack {
                TabBarButton(icon: "home", title: "", index: 0, selectedTab: $selectedTab)
                Spacer()
                TabBarButton(icon: "analysis", title: "", index: 1, selectedTab: $selectedTab)
                Spacer()
                TabBarButton(icon: "settings", title: "", index: 2, selectedTab: $selectedTab)
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)
        }
        .padding(.top, 20)
        .padding(.bottom, getSafeAreaBottom()+8)
        .background(
            Color(.lightFrame)

        )
        .clipShape(RoundedCorners(radius: 30, corners: [.topLeft, .topRight]))
        .ignoresSafeArea(edges: .bottom)
    }
}

struct TabBarButton: View {
    let icon: String
    let title: String
    let index: Int
    @Binding var selectedTab: Int

    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = index
            }
        }) {
            VStack(spacing: 4) {
                Image(selectedTab == index ? "\(icon)_fill" : icon)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }
            .foregroundColor(selectedTab == index ? .yellowMain : .lightText)
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(1), searchText: .constant(""))
        .ignoresSafeArea()
        .background(.black)
}
