//
//  CreatePostTableViewController.swift
//  CoreData-NumberFacts
//
//  Created by Yuliia Engman on 4/8/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class CreatePostTableViewController: UITableViewController {
    
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var numberFactTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
    }
    
    private func configurePickerView() {
        pickerView.dataSource = self
       // pickerView.delegate = self
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
    }

}

extension CreatePostTableViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    
}

//extension CreatePostTableViewController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        <#code#>
//    }
//}
