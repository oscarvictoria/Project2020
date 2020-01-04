//
//  ViewController.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 12/31/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
@IBOutlet weak var tableView: UITableView!
@IBOutlet weak var searchBar: UISearchBar!
    

    var books = [Items]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }

    func loadBooks() {
        BooksAPIClient.getBooks(searchQuery: "swift") { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let item):
                self.books = item
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let bookDVC = segue.destination as? BookDVC,
        let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("error")
        }
        
        let book = books[indexPath.row]
        bookDVC.detailBook = book
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookCell else {
            fatalError()
        }
        let book = books[indexPath.row]
        cell.configured(for: book)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            print("error")
            return
        }
        
        BooksAPIClient.getBooks(searchQuery: searchText) { (result) in
                switch result {
                case .failure(let appError):
                    print("app error: \(appError)")
                case .success(let item):
                    self.books = item
                }
            }
        }
    }

