//
//  DataController.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/10/22.
//

import Foundation
import CoreData

class DataController {
    // model objects array of NSManagedObjects
    let persistentContainer: NSPersistentContainer
    
    init(completion: @escaping () -> Void) {
        persistentContainer = NSPersistentContainer(name: "SavedGifsModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: ", error)
            }
            completion()
        }
    }
    
    // functions for needed CRUD operations
}
