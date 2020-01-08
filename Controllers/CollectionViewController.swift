//
//  CollectionViewController.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 1/3/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    
@IBOutlet weak var collectionView: UICollectionView!
@IBOutlet weak var searchBar: UISearchBar!
    
    var books = [Items]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self 
        
    }
    
    func loadData() {
        BooksAPIClient.getBooks(searchQuery: "Swift") { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let item):
                self.books = item
            }
        }
    }
    
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionCell else {
            fatalError("error")
        }
        
        let book = books[indexPath.row]
        let imageURL = "http://books.google.com/books/content?id=\(book.id)&printsec=frontcover&img=1&zoom=4&edge=curl&imgtk=AFLRE710CSJSqWFZNoJSuGEuoEar36sa7fwTZWbPvDTK_pn7F39fEj6C3HTBp4huTZTzivqPkCkqKXrqhf8gELHuWqcokJAcWIhFcngxy0qOuy7EUpfloDvLOz_a8DYIKeInhRmHyiaI&source=gbs_api"
        cell.title.text = book.volumeInfo?.title ?? ""
        cell.author.text = book.volumeInfo?.authors?.first ?? ""
        cell.bookImage.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.bookImage.image = image
                }
            }
        }
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 630)
    }
}

extension CollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            print("error")
            return
        }
        
         
            BooksAPIClient.getBooks(searchQuery: searchText) { (result) in
                switch result {
                case .failure(let error):
                    print("error \(error)")
                case .success(let item):
                    self.books = item
                }
            }
        
        
    }
}
