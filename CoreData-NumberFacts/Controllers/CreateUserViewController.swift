//
//  CreateUserTableViewController.swift
//  CoreData-NumberFacts
//
//  Created by Yuliia Engman on 4/8/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

// 1- custom protocol
protocol CreateUserDelegate: AnyObject {
    func didCreateUser(_ createUserTableViewController: CreateUserViewController, user: User)
}

class CreateUserViewController: UITableViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //2 - custom protocol
    weak var delegate: CreateUserDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.maximumDate = Date()
    }
    

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let usernameText = usernameTextField.text, !usernameText.isEmpty else {
            print("missing user name")
            return
        }
        
        let date = datePicker.date
        
       let user = CoreDataManager.shared.createUser(name: usernameText, dob: date)
        
        delegate?.didCreateUser(self, user: user)
        
        dismiss(animated: true)
    
    }
    

}
