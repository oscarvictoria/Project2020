//
//  List.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 1/5/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct List: Codable {
    let results: Results
}

struct Results: Codable {
    let books: [BookData]
}

struct BookData: Codable {
    let rank: Int
    let title: String
    let author: String
    let primary_isbn13: String
}
