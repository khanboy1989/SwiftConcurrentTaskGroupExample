//
//  QuoteListViewModel.swift
//  SwiftConcurrentTaskGroupExample
//
//  Created by Serhan Khan on 24/04/2025.
//

import SwiftUI
import Observation

@Observable
final class QuoteListViewModel {
    var quotes: [QuoteItem] = []
    var isLoading: Bool = false
    private let webServices: WebServices
    init(webSerices: WebServices = WebServices()) {
        self.webServices = webSerices
    }
    
    func fetchQuotes() async {
        self.isLoading = true
        do {
            let quoteItems = try await webServices.fetchImageAndQuote(for: 1...50)
            self.isLoading = false
            self.quotes = quoteItems
        } catch {
            print("Error = \(error)")
            self.isLoading = false
        }
    }
    func fetchQuotesSynchronously(for range: ClosedRange<Int>) async {
       for id in range {
           do {
               let item = try await webServices.fetchImageAndQuoteSync(for: id)
               quotes.append(item)
           } catch {
               print("Error = \(error)")
           }
        }
    }
    
    func fetchQuotesInSync(for range: ClosedRange<Int>) async {
        isLoading = true
        do {
            try await withThrowingTaskGroup(of: QuoteItem?.self) { group in
                for id in range {
                    group.addTask {
                        try await self.webServices.fetchImageAndQuoteSync(for: id)
                    }
                }
                
                for try await item in group {
                    if let item = item {
                        self.quotes.append(item)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
    }
}
