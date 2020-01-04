//
//  Books.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 12/31/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct Books: Codable {
    let items: [Items]?
}

struct Items: Codable {
    let volumeInfo: volumeInfo
    let id: String
}

struct volumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let imageLinks: ImageLinks?
    let favoritedBy: String?
}

struct ImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
    
}
