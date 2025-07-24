//
//  SettingsView.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    @State private var showNotificationAlert = false

    @State private var showImagePicker = false
    @State private var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var showSourceSheet = false

    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 15) {
                Text("Settings")
                    .foregroundStyle(.yellowMain)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.bottom, 30)
                Button {
                    if let url = URL(string: "https://example.com") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack {
                        Text("Rate App")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .layoutPriority(1)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.darkFrame)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Button {
                    if let url = URL(string: "https://example.com") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack {
                        Text("Terms Of Use")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .layoutPriority(1)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.darkFrame)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Button {
                    if let url = URL(string: "https://example.com") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack {
                        Text("Privacy Policy")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .layoutPriority(1)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.darkFrame)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Button {
                    userService.isFirstLaunch = true
                } label: {
                    HStack {
                        Text("Onboarding")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .layoutPriority(1)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.darkFrame)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                HStack {
                    Text("Notification")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(1)
                    Spacer()
                    Toggle("", isOn: Binding(
                        get: { userService.isNotificationEnabled },
                        set: { newValue in
                            userService.toggleNotifications(to: newValue) {
                                showNotificationAlert = true
                            }
                        }
                    ))
                    .toggleStyle(CustomToggleStyle())
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(.darkFrame)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                HStack {
                    Text("Vibration")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(1)
                    Spacer()
                    Toggle("", isOn: $userService.isVibration)
                    .toggleStyle(CustomToggleStyle())
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(.darkFrame)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.bottom)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
            .padding(.bottom, getSafeAreaBottom())
        }
        .alert("Notifications Disabled", isPresented: $showNotificationAlert) {
            Button("Open Settings") {
                NotificationManager.shared.openAppSettings()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("To enable notifications, please allow them in Settings.")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(UserService())
        .background(.black)
}


#Preview {
    NavigationStack {
        NavigationLink("Settings") {
            SettingsView()
                .environmentObject(UserService())
                .background(.black)
        }
    }
}
