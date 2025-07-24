//
//  MaterialPreviewView.swift
//  Pinup
//
//  Created by Кирилл Архипов on 07.07.2025.
//

import SwiftUI

struct MatchPreView: View {
    @EnvironmentObject var userService: UserService
    @State private var isOpened = false
    var isAnalyzed: Bool = false
    var match: MatchModel

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.spring()) {
                    isOpened.toggle()
                }
            } label: {
                HStack {
                    Text(match.name)
                        .font(.system(size: 24, weight: .semibold))
                    Spacer()
                    if isAnalyzed {
                        Button {
                            withAnimation {
                                userService.match = match
                                userService.isAddingMatch = true
                            }
                        } label: {
                            Image(systemName: "pencil")
                                .font(.system(size: 24))
                        }
                    }
                    Image(systemName: "chevron.up")
                        .rotationEffect(.degrees(isOpened ? -180 : 0))
                        .font(.system(size: 24))
                }
            }
            .foregroundStyle(isOpened ? .black : .white)
            .padding(20)
            .background(
                RoundedCorners(radius: 30, corners: [.topLeft, .topRight])
                    .fill(Color.yellowMain)
                    .frame(height: isOpened ? nil : 0, alignment: .top)
            )
            if isOpened {
                VStack (alignment: .leading, spacing: 0) {
                    HStack {
                        Text("• Location")
                        Spacer()
                        Text("\(match.location)")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    HStack {
                        Text("• Weather")
                        Spacer()
                        Text("\(match.weather)")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        Rectangle()
                            .fill(.muchDarkFrame)
                    )
                    HStack {
                        Text("• Goals")
                        Spacer()
                        Text("\(match.goals)")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    HStack {
                        Text("• Penalty Fees")
                        Spacer()
                        Text("\(match.penaltyFees)")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        Rectangle()
                            .fill(.muchDarkFrame)
                    )
                    HStack {
                        Text("• FCP - Possession (%)")
                        Spacer()
                        Text("\(match.teamPossession)")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)

                }
                .foregroundStyle(.yellowMain)
                .font(.system(size: 14))
                if isAnalyzed {
                    Rectangle()
                        .fill(.yellowMain)
                        .frame(height: 1)
                    VStack (alignment: .leading, spacing: 0) {
                        Text("AI Analysis")
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .bold))
                            .multilineTextAlignment(.leading)
                            .padding(.bottom)
                        Text(match.analysis)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.lightText)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(20)
                }
            }
        }
        .background(
            Rectangle()
                .fill(.darkFrame)
        )
        .clipShape (
            RoundedRectangle(cornerRadius: 30)
        )
    }
}
#Preview {
    MatchPreView(isAnalyzed: true, match: MatchModel(name: "FCP vs RMA", location: "Parc des Princes", weather: "Clear", goals: "123", penaltyFees: "1", teamPossession: "something"))
}
