//
//  PersistenceService.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 09/06/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService {

    private init() {}

    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Friend_Trip")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    static func saveContext () {
        let context = persistentContainer.viewContext
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
