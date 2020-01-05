//
//  BestSellersVC.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 1/5/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class BestSellersVC: UIViewController {
    
@IBOutlet weak var tableView: UITableView!
    
    var list = [BookData]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadList()
    }
    
    func loadList() {
        BooksAPIClient.getList { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let list):
                self.list = list
            }
        }
    }
  

}

extension BestSellersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        let listData = list[indexPath.row]
        cell.textLabel?.text = listData.title
        return cell
    }
}
