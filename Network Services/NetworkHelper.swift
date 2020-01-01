//
//  NetworkHelper.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 12/31/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

class NetworkHelper {
 
  static let shared = NetworkHelper()
  
  private var session: URLSession
  

  private init() {
    session = URLSession(configuration: .default)
  }
  
  func performDataTask(with request: URLRequest,
                       completion: @escaping (Result<Data, AppError>) -> ()) {

    
    let dataTask = session.dataTask(with: request) { (data, response, error) in
      
  
      if let error = error {
        completion(.failure(.networkClientError(error)))
        return
      }
      
      
      guard let urlResponse = response as? HTTPURLResponse else {
        completion(.failure(.noResponse))
        return
      }
      
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
     
      switch urlResponse.statusCode {
      case 200...299: break
      default:
        completion(.failure(.badStatusCode(urlResponse.statusCode)))
        return
      }
      
      
      completion(.success(data))
    }
    dataTask.resume()
  }
}
