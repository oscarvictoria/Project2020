//
//  Favorite Books.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 1/4/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct favoriteBooks: Codable {
    let id: String
    let title: String
    let authors: [String]
//  let response: String
    let favoritedBy: String
}
