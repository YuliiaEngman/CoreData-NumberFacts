//
//  CreatePostTableViewController.swift
//  CoreData-NumberFacts
//
//  Created by Yuliia Engman on 4/8/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

protocol CreatePostDelegate: AnyObject {
    func didCreatePost(_ createPostViewController: CreatePostViewController, post: Post)
}

class CreatePostViewController: UITableViewController {
    
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var numberFactTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    weak var delegate: CreatePostDelegate?
    
    private var users = [User]()
    
    private var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        fetchUsers()
        selectedUser = users.first
    }
    
    private func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func fetchUsers() {
        users = CoreDataManager.shared.fetchUser()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        // validating data - checking to make sure that it is not empty and also number is a valid Double (post title, number)
        // selected user
        
        guard let postTitle = postTitleTextField.text, !postTitle.isEmpty,
            let numberFactText = numberFactTextField.text,
            !numberFactText.isEmpty,
            let numberFact = Double(numberFactText) else {
                print("missimg fields")
                return
        }
        
        guard let user = selectedUser else {
            print("no user selected")
            return
        }
        
        // create post in core data
        let post = CoreDataManager.shared.createPost(for: user, numberFact: numberFact, title: postTitle)
        
        delegate?.didCreatePost(self, post: post)
        
        dismiss(animated: true)
    }

}

extension CreatePostViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    
}

extension CreatePostViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUser = users[row]
    }
}
