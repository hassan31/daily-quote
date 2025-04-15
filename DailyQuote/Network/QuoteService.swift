//
//  QuoteService.swift
//  DailyQuote
//
//  Created by Muhammad Hassan on 2025-04-15.
//

import Foundation

protocol QuoteServiceProtocol {
    func fetchRandomQuote() async throws -> Quote
}

class QuoteService: QuoteServiceProtocol {
    static let shared = QuoteService()
    
    private init() {}

    func fetchRandomQuote() async throws -> Quote {
        guard let url = URL(string: APIConstants.baseURL + "v1/quotes") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.setValue(APIConstants.apiKey, forHTTPHeaderField: "X-Api-Key")

        let (data, _) = try await URLSession.shared.data(for: request)

        let quotes = try JSONDecoder().decode([Quote].self, from: data)
        guard let firstQuote = quotes.first else {
            throw NSError(domain: "No quotes found", code: 0)
        }

        return firstQuote
    }
}
