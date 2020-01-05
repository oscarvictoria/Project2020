//
//  FavoritesVC.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 1/4/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

@IBOutlet weak var tableView: UITableView!
    
    var theBooks = [favoriteBooks]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        BooksAPIClient.getFavorites { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let items):
                self.theBooks = items
            }
        }
    }
  

}

extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        let favorites = theBooks[indexPath.row]
        cell.textLabel?.text = favorites.title
        return cell
    }
}
