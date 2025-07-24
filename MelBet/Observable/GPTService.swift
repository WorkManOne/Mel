//
//  GPTService.swift
//  Mel
//
//  Created by Кирилл Архипов on 24.07.2025.
//

import Foundation

class GPTService {
    private let apiKey = "sk-INSERT-APIKEY-HERE"

    func generateMatchAnalysis(from match: MatchModel, completion: @escaping (String?) -> Void) {
        let prompt = """
        Analyze this football match based on the following data:
        Name: \(match.name)
        Location: \(match.location)
        Weather: \(match.weather)
        Goals: \(match.goals)
        Penalty Fees: \(match.penaltyFees)
        Team Possession: \(match.teamPossession)
        Corners: \(match.corners)
        Offsides: \(match.offsides)
        Fouls: \(match.fouls)
        xG: \(match.xg)
        Rating: \(match.rating)

        Write a brief analysis summarizing the match.
        """

        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        let headers = [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json"
        ]

        let body: [String: Any] = [
            "model": "gpt-4",
            "messages": [
                ["role": "system", "content": "You are a helpful football analyst."],
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.7
        ]

        guard let bodyData = try? JSONSerialization.data(withJSONObject: body) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = bodyData

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data,
                  let result = try? JSONDecoder().decode(ChatGPTResponse.self, from: data),
                  let reply = result.choices.first?.message.content else {
                print("GPT Error:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }

            completion(reply.trimmingCharacters(in: .whitespacesAndNewlines))
        }.resume()
    }
}

struct ChatGPTResponse: Codable {
    struct Choice: Codable {
        struct Message: Codable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}
