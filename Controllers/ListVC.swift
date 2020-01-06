//
//  ListVC.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 1/5/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    
    
@IBOutlet weak var tableView: UITableView!
@IBOutlet weak var textField: UITextField!
    
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
            textField.delegate = self
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
      

    }

    extension ListVC: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return list.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
            let listData = list[indexPath.row]
            cell.textLabel?.text = listData.title
            return cell
        }

}

extension ListVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        BooksAPIClient.getList(list: title ?? "", date: textField.text ?? "") { (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success(let listData):
                self.list = listData
            }
        }
        return true
    }
}
