//
//  MatchModel.swift
//  Bovada
//
//  Created by Кирилл Архипов on 16.07.2025.
//

import Foundation

struct MatchModel: Identifiable, Codable {
    var id: UUID = UUID()
    var isSaved: Bool = false
    var name: String = ""
    var location: String = ""
    var weather: String = ""
    var goals: String = ""
    var penaltyFees: String = ""
    var teamPossession: String = ""
    var corners: String = ""
    var offsides: String = ""
    var fouls: String = ""
    var xg: String = ""
    var rating: String = ""
    var analysis: String = ""
}
