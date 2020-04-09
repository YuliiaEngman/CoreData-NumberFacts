//
//  Post+CoreDataProperties.swift
//  CoreData-NumberFacts
//
//  Created by Yuliia Engman on 4/9/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var number: Double
    @NSManaged public var title: String?
    @NSManaged public var location: String?
    @NSManaged public var user: User?

}
