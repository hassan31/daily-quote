//
//  QuoteViewModel.swift
//  DailyQuote
//
//  Created by Muhammad Hassan on 2025-04-15.
//

import Foundation

class QuoteViewModel: ObservableObject {
    @Published var quote: Quote?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let quoteService: QuoteServiceProtocol
    
    init(quoteService: QuoteServiceProtocol = QuoteService.shared) {
        self.quoteService = quoteService
    }

    @MainActor
    func fetchQuote() async {
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            let fetchedQuote = try await quoteService.fetchRandomQuote()
            self.quote = fetchedQuote
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
