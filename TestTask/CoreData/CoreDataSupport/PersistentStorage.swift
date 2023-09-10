//
//  PersistentStorage.swift
//  TestTask
//
//  Created by Ashish Yadav on 08/09/23.
//

import Foundation
import CoreData

final class PersistentStorage {
   
    
    
    private init() {}
    static let shared = PersistentStorage()

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "TestTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
   lazy var context = persistentContainer.viewContext
    func saveContext () {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
