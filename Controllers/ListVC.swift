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
@IBOutlet weak var datePicker: UIDatePicker!
    
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


