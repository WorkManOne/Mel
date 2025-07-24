//
//  UserDataModel.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import Foundation
import SwiftUI

class UserService: ObservableObject {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    @AppStorage("isVibration") var isVibration: Bool = false
    @AppStorage("isNotificationEnabled") var isNotificationEnabled: Bool = false

    @Published var isAddingMatch: Bool = false
    @Published var isShowingAnalyzing: Bool = false
    @Published var isAnalyzing: Bool = false
    @Published var match: MatchModel? = nil
    @Published var analysis: String = ""

    @Published var matches: [MatchModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(matches), forKey: "matches")
        }
    }

    init() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "matches"),
           let decoded = try? JSONDecoder().decode([MatchModel].self, from: data) {
            matches = decoded
        } else {
            matches = []
        }
    }

    func reset() {
        isFirstLaunch = true
        isVibration = false
        isNotificationEnabled = false
        matches = []
    }

    func toggleNotifications(to newValue: Bool, onDenied: @escaping () -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .denied:
                    onDenied()
                    self.isNotificationEnabled = false
                    NotificationManager.shared.removeScheduledNotifications()

                case .notDetermined:
                    NotificationManager.shared.requestPermission { granted in
                        DispatchQueue.main.async {
                            self.isNotificationEnabled = granted && newValue
                            if self.isNotificationEnabled {
                                NotificationManager.shared.scheduleNotification()
                            } else {
                                NotificationManager.shared.removeScheduledNotifications()
                            }
                        }
                    }

                case .authorized, .provisional, .ephemeral:
                    self.isNotificationEnabled = newValue
                    if newValue {
                        NotificationManager.shared.scheduleNotification() // << Здесь — если включено
                    } else {
                        NotificationManager.shared.removeScheduledNotifications()
                    }

                @unknown default:
                    self.isNotificationEnabled = false
                    NotificationManager.shared.removeScheduledNotifications()
                }
            }
        }
    }

}
