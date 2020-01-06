//
//  PickerVC.swift
//  Project2020
//
//  Created by Oscar Victoria Gonzalez  on 1/5/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class PickerVC: UIViewController {
    
    
    @IBOutlet weak var listPickerView: UIPickerView!
    
    
    private let list = ["Combined Print and E-Book Nonfiction", "Hardcover Fiction", "Hardcover Nonfiction", "Trade Fiction Paperback", "Mass Market Paperback", "Paperback Nonfiction", "E-Book Fiction", "E-Book Nonfiction",  "Hardcover Advice", "Paperback Advice","Advice How-To and Miscellaneous", "Hardcover Graphic Books", "Paperback Graphic Books","Manga", "Combined Print Fiction", "Combined Print Nonfiction", "Chapter Books", "Childrens Middle Grade", "Paperback Books", "Business Books", "Education", "Science", "Sports", "Travel"].sorted()
    
    private var listName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listPickerView.dataSource = self
        listPickerView.delegate = self
        
        listName = list.first
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customSegue" {
            guard let listVC = segue.destination as? ListVC else {
                fatalError("error")
            }
            listVC.title = self.listName
        }
    }
    
    
    
    
    
    @IBAction func submit(_ sender: UIButton) {
        self.performSegue(withIdentifier: "customSegue", sender: nil)
        
    }
    
}

extension PickerVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        listName = list[row]
    }
    
    
    
    
    
}

extension PickerVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
}



