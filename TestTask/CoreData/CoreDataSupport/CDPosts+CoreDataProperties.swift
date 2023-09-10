//
//  CDPosts+CoreDataProperties.swift
//  
//
//  Created by Ashish Yadav on 10/09/23.
//
//

import Foundation
import CoreData


extension CDPosts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPosts> {
        return NSFetchRequest<CDPosts>(entityName: "CDPosts")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int32
    @NSManaged public var isFavourite: Bool
    @NSManaged public var title: String?
    @NSManaged public var userID: Int32

}
