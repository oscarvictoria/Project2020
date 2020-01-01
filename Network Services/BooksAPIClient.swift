//
//  BooksAPIClient.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 12/31/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct BooksAPIClient {
    static func getBooks(searchQuery: String,completion: @escaping (Result <[Items], AppError>)-> ()) {
    
    let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "book"
    
    let endpointURLString = "https://www.googleapis.com/books/v1/volumes?q=\(searchQuery)&maxResults=5"
    
    
    guard let url = URL(string: endpointURLString) else {
        completion(.failure(.badURL(endpointURLString)))
        return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { (result) in
        switch result {
        case .failure(let appError):
            completion(.failure(.networkClientError(appError)))
        case .success(let data):
            do {
                let books = try JSONDecoder().decode(Books.self, from: data)
                let book = books.items
                completion(.success(book ?? []))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
    }
    
}
}
