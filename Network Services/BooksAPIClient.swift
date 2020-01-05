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
    
    let endpointURLString = "https://www.googleapis.com/books/v1/volumes?q=\(searchQuery)&maxResults=15"
    
    
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
    
    static func postFavorites(book: volumeInfo, completion: @escaping (Result <Bool, AppError>)-> ()) {
        
        let endpointURLString = "https://5e11123483440f0014d83035.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        
        do {
            let data = try JSONEncoder().encode(book)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    print("app error \(appError)")
                case .success:
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(.encodingError(error)))
        }

        
    }
    
    static func getFavorites(completion: @escaping (Result <[favoriteBooks], AppError>)-> ()) {
        
         let endpointURLString = "https://5e11123483440f0014d83035.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: endpointURLString) else {
                completion(.failure(.badURL(endpointURLString)))
                return
            }
            
            let request = URLRequest(url: url)
            
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    print("error \(appError)")
                case .success(let data):
                    do {
                        let favorites = try JSONDecoder().decode([favoriteBooks].self, from: data)
                        completion(.success(favorites))
                    } catch {
                        completion(.failure(.decodingError(error)))
                    }
                }
            }
        
    }
    
    static func getList(completion: @escaping (Result <[BookData], AppError>)-> ()) {
        
    let endpointURLString = "https://api.nytimes.com/svc/books/v3/lists/current/Business-Books.json?api-key=YfFmebKIif8db1bZE3oj2IIepa7SFgPH"
        
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
                    let list = try JSONDecoder().decode(List.self, from: data)
                    let bookData = list.results.books
                    completion(.success(bookData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
