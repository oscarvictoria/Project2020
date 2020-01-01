//
//  BookCell.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 12/31/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
@IBOutlet weak var bookImageView: UIImageView!
@IBOutlet weak var bookTitleLabel: UILabel!
@IBOutlet weak var bookAuthorLabel: UILabel!
    
    func configured(for book: Items) {
        bookTitleLabel.text = book.volumeInfo.title ?? ""
        bookAuthorLabel.text = book.volumeInfo.authors?.first
        bookImageView.getImage(with: book.volumeInfo.imageLinks?.thumbnail ?? "") { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.bookImageView.image = image
                }
            }
        }
}
}
