//
//  ListVC.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 1/5/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    
@IBOutlet weak var collectionView: UICollectionView!
@IBOutlet weak var datePicker: UIDatePicker!
    
     
    var list = [BookData]() {
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
            datePicker.backgroundColor = .systemYellow
            loadList()
        }
        
        func loadList() {
            BooksAPIClient.getList(list: title ?? "", date: "current") { (result) in
                switch result {
                case .failure(let error):
                    print("\(error)")
                case .success(let listData):
                    self.list = listData
                }
            }

        }
  
    
    
    @IBAction func submit(_ sender: UIButton) {
        let myDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = myDate
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:date)
        BooksAPIClient.getList(list: title ?? "", date: dateString) { (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success(let listData):
                self.list = listData
                print(dateString)
            }
        }
    }
    
  
    
}

extension ListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? ListCell else {
            fatalError("cannot get cell")
        }
        let lists = list[indexPath.row]
        let imageURL = "https://s1.nyt.com/du/books/images/\(lists.primary_isbn13).jpg"
        cell.titleLabel.text = lists.title
        cell.imageView.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }
        
        return cell
    }
}

extension ListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 400, height: 400)
       }
}
