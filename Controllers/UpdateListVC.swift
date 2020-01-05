//
//  UpdateListVC.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 1/5/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class UpdateListVC: UIViewController {
    
@IBOutlet weak var listPickerView: UIPickerView!
    
    private let list = ["Combined Print and E-Book Nonfiction", "Hardcover Fiction", "Hardcover Nonfiction", "Trade Fiction Paperback", "Mass Market Paperback", "Paperback Nonfiction", "E-Book Fiction", "E-Book Nonfiction",  "Hardcover Advice", "Paperback Advice","Advice How-To and Miscellaneous", "Hardcover Graphic Books", "Paperback Graphic Books","Manga", "Combined Print Fiction", "Combined Print Nonfiction", "Chapter Books", "Childrens Middle Grade", "Paperback Books", "Business Books", "Education", "Science", "Sports", "Travel"].sorted()
    
    private var listName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listPickerView.dataSource = self
        listPickerView.delegate = self

        listName = list.first
    }
    

  
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func updateList(_ sender: UIBarButtonItem) {
        guard let listName = listName else {
            return
        }
        
        BooksAPIClient.getList(list: listName) { (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success:
                print("success")
                
            }
        }
    }
    
    
    
}

extension UpdateListVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        list.count
    }
    
    
    
}

extension UpdateListVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
}
