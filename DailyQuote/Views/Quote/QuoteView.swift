//
//  QuoteView.swift
//  DailyQuote
//
//  Created by Muhammad Hassan on 2025-04-15.
//

import SwiftUI

// Views/ContentView.swift
import SwiftUI

struct QuoteView: View {
    @StateObject private var viewModel = QuoteViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let quote = viewModel.quote {
                Text("\"\(quote.quote)\"")
                    .font(.title2)
                    .padding()
                Text("- \(quote.author)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            }

            Button("New Quote") {
                Task {
                    await viewModel.fetchQuote()
                }
            }
            .padding()
        }
        .onAppear {
            Task {
                await viewModel.fetchQuote()
            }
        }
    }
}

#Preview {
    QuoteView()
}
