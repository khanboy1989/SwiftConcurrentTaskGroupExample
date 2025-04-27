//
//  WebServices.swift
//  SwiftConcurrentTaskGroupExample
//
//  Created by Serhan Khan on 24/04/2025.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case badUrl
    case invalidImage(Int)
    case decodingError
    case quoteNotFound(Int)
}

actor WebServices {
    /*
     ✅ Highlights:
         •    async let used inside TaskGroup for parallel API calls per ID.
         •    Each task is fully independent — no shared state.
         •    NetworkError enum provides detailed feedback per issue.
         •    QuoteItem combines the result of both APIs into a single model.
     */
    func fetchImageAndQuote(for ids: ClosedRange<Int>) async throws -> [QuoteItem] {
        return try await withThrowingTaskGroup(of: QuoteItem?.self) { group in
            for id in ids {
                group.addTask {
                    let imageUrlString = "https://picsum.photos/id/\(id)/400/300"
                    let quoteUrlString = "https://dummyjson.com/quotes/\(id)"
                    
                    guard let imageUrl = URL(string: imageUrlString),
                          let quoteUrl = URL(string: quoteUrlString) else {
                        throw NetworkError.badUrl
                    }
                    
                    async let imageData = URLSession.shared.data(from: imageUrl)
                    async let quoteData = URLSession.shared.data(from: quoteUrl)

                    let (imageResult, quoteResult) = try await (imageData, quoteData)

                    guard let image = UIImage(data: imageResult.0) else {
                        throw NetworkError.invalidImage(id)
                    }

                    let decodedQuote = try JSONDecoder().decode(Quoute.self, from: quoteResult.0)
                    
                    return QuoteItem(quote: decodedQuote, image: image)
                }
            }
            var items: [QuoteItem] = []
            for try await item in group {
                if let item = item {
                    items.append(item)
                }
            }
            return items
        }
    }
    
    func fetchImageAndQuoteSync(for id: Int) async throws -> QuoteItem {
        let imageUrlString = "https://picsum.photos/id/\(id)/400/300"
        let quoteUrlString = "https://dummyjson.com/quotes/\(id)"
        
        guard let imageUrl = URL(string: imageUrlString),
              let quoteUrl = URL(string: quoteUrlString) else {
            throw NetworkError.badUrl
        }
        
        async let imageData = URLSession.shared.data(from: imageUrl)
        async let quoteData = URLSession.shared.data(from: quoteUrl)
        
        let (imageResult, quoteResult) = try await (imageData, quoteData)
        
        guard let image = UIImage(data: imageResult.0) else {
            throw NetworkError.invalidImage(id)
        }
        
        let decodedQuote = try JSONDecoder().decode(Quoute.self, from: quoteResult.0)

        return QuoteItem(quote: decodedQuote, image: image)
    }
}
