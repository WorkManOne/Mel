//
//  EditMaterialView.swift
//  Pinup
//
//  Created by Кирилл Архипов on 07.07.2025.
//

import SwiftUI

struct EditMatchView: View {
    @EnvironmentObject var userService: UserService
    @State private var match: MatchModel

    private var isEditing: Bool {
        return userService.match != nil
    }

    init(match: MatchModel? = nil) {
        if let existingMatch = match {
            _match = State(initialValue: existingMatch)
        } else {
            _match = State(initialValue: MatchModel())
        }
    }

    var body: some View {
        ZStack (alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Button {
                            withAnimation {
                                userService.isAddingMatch = false
                                userService.match = nil
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.yellowMain)
                        }
                        Text(isEditing ? "Edit Match" : "Add Match")

                    }
                    .foregroundStyle(.yellowMain)
                    .font(.system(size: 24, weight: .bold))
                    TemplateTextField(title: "Name Of Match", parameter: $match.name, placeholder: "Name")
                    TemplateTextField(title: "Location", parameter: $match.location, placeholder: "Location")
                    TemplateTextField(title: "Weather", parameter: $match.weather, placeholder: "Weather")
                    TemplateTextField(title: "Penalty Fees", parameter: $match.penaltyFees, placeholder: "Penalty fees")
                    TemplateTextField(title: "Team - Possession (%)", parameter: $match.teamPossession, placeholder: "Possession (%)")
                    TemplateTextField(title: "Team - Corners", parameter: $match.corners, placeholder: "Corners")
                    TemplateTextField(title: "Team - Offsides", parameter: $match.offsides, placeholder: "Offsides")
                    TemplateTextField(title: "Team - Fouls", parameter: $match.fouls, placeholder: "Fouls")
                    TemplateTextField(title: "Team - XG", parameter: $match.xg, placeholder: "XG")
                    TemplateTextField(title: "Team - Rating", parameter: $match.rating, placeholder: "Rating")
                }
                .padding(.bottom, 40)
            }
            .padding(.bottom, getSafeAreaBottom())
            Button {
                if isEditing {
                    if let index = userService.matches.firstIndex(where: { $0.id == match.id }) {
                        userService.matches[index] = match
                    }
                } else {
                    match.id = UUID()
                    userService.matches.append(match)
                }
                withAnimation {
                    userService.isAddingMatch = false
                    userService.match = nil
                }
            } label: {
                Text(isEditing ? "Save" : "Add Match")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .colorFramed(color: .yellowMain)
            }
        }
        .padding(.horizontal, 20)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
        .onAppear {
            if let editingMatch = userService.match {
                match = editingMatch
            }
        }
    }
}

struct TemplateTextField: View {
    var title: String = ""
    @Binding var parameter: String
    var placeholder: String = ""


    var body: some View {
        VStack {
            Text(title)
                .foregroundStyle(.white)
                .font(.system(size: 14, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                TextField("", text: $parameter, prompt: Text(placeholder).foregroundColor(.lightText))
                    .foregroundStyle(.white)
                    .font(.system(size: 14))
                Button {
                    parameter = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.lightText)
                        .frame(height: 20)
                }
            }
            .darkFramed()
        }
    }
}

#Preview {
    EditMatchView()
        .background(.black)
}
