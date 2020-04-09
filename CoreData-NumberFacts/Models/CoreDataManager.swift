//
//  CoreDateManager.swift
//  CoreData-NumberFacts
//
//  Created by Yuliia Engman on 4/9/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    // implement singleton
    static let shared = CoreDataManager()
    private init() {}
    
    private var users = [User]() // User is a NSMangedObject, we can see that "public class User: NSManagedObject" in file User+CoreDataClass
    private var posts = [Post]()

    // we need access the persistance container's reference (from AppDelegate)
    // need to import UIKit + CoreData
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //viewContext is of type NSManagedObjectContext
    
    // CRUD = create read update delete
    
    public func createUser(name: String, dob: Date) -> User {
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        user.dob = dob
        
        //SAVE CHANGES to SManagedObjectContext
        
        //now we need actually save changs to SManagedObjectContext
        // persistance - saving data
        // persistance: user defaults, documents derectory, firebase, core data, iCloud
        //similar to saving to file manager
        
        do {
            try context.save() //SManagedObjectContext
        } catch {
            print("error saving user: \(error)")
        }
        return user
    }
    
    public func fetchUser() -> [User] {
        do {
            users = try context.fetch(User.fetchRequest()) // gets all the objects from core data
            // We can use NSPredicate to sort and filter Core Data objects during fetching
            // Fetch request is of the type NSFetchRequest
        } catch {
            print("error fetching users error: \(error)")
        }
        return users
    }
    
    public func createPost(for user: User, numberFact: Double, title: String) -> Post {
        
        // create a Post
        let post = Post(entity: Post.entity(), insertInto: context) // empty post
        
        // set the post property
        post.number = numberFact
        post.title = title
        
        // create relztionship between post and user
        post.user = user // this relationship was created by ctrl + drag in the core data graphical model
        
        // saving Post to the NSManagedObjectContext (Core Data)
        do {
            try context.save()
        } catch {
            print("creating saving post: \(error)") // throwing function ideal here
        }
        return post
    }
    
    // delete
    @discardableResult // silences the warning if returned value is not used
    public func deletePost(_ post: Post) -> Bool {
        var wasDeleted = false
        context.delete(post)
        
        //save context
        do {
            try context.save()
            wasDeleted = true
        } catch {
            print("failed to delete post with error: \(error)")
        }
        return wasDeleted
        }
    
    public func fetchPosts() -> [Post] {
        do {
            posts = try context.fetch(Post.fetchRequest())
        } catch {
           print("failed to fetch posts with error: \(error)")
        }
        return posts
    }
}
