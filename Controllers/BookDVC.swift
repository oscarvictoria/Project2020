//
//  BookDVC.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 1/4/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class BookDVC: UIViewController {
    
@IBOutlet weak var bookImageView: UIImageView!
    
var detailBook: Items?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let someBooks = detailBook else {
            fatalError("error")
        }
        
        let imageURL = "http://books.google.com/books/content?id=\(someBooks.id)&printsec=frontcover&img=1"
        
        bookImageView.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.bookImageView.image = image
                }
            }
        }
    }
    
    
    
    @IBAction func favorite(_ sender: UIButton) {
        
        print("button pressed")
        
        guard let favorites = detailBook else {
            print("error")
            return
        }
        
        let bookFavorites = volumeInfo(title: favorites.volumeInfo?.title, authors: favorites.volumeInfo?.authors, imageLinks: nil ,favoritedBy: "Oscar")
     
        BooksAPIClient.postFavorites(book: bookFavorites) { (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success:
                print("success")
            }
        }
        
    }
    

}
