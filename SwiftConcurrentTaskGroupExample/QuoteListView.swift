//
//  QuoteListView.swift
//  SwiftConcurrentTaskGroupExample
//
//  Created by Serhan Khan on 24/04/2025.
//

import SwiftUI

struct QuoteListView: View {
    @State private var quoteListViewModel = QuoteListViewModel()
    
    var body: some View {
        ZStack {
            if quoteListViewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                    .tint(.white)
            } else {
                List(quoteListViewModel.quotes, id: \.id) { quote in
                    HStack {
                        Image(uiImage: quote.image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                        VStack(alignment: .leading) {
                            Text(quote.quote.author)
                                .font(.caption)
                            Text(quote.quote.quote)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }.task {
//            await quoteListViewModel.fetchQuotes()
            await quoteListViewModel.fetchQuotesInSync(for: 1...50)
        }
        
    }
}
