//
//  DataController.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/10/22.
//

import Foundation
import CoreData

// Currently unused, did not finish this implementation, so just using UserDefaults for now
class DataController {
    static let shared = DataController { }
    var resume: NSManagedObject?
    let persistentContainer: NSPersistentContainer
    
    init(completion: @escaping () -> Void) {
        persistentContainer = NSPersistentContainer(name: "ResumeBuilder")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: ", error)
            }
            completion()
        }
    }
    
    func saveNewResume(address: String = "", objective: String = "", email: String = "", name: String = "", phoneNumber: String = "", photo: Data = Data(), skills: [String] = [], yearsExperience: Int = -1) {
        let managedObjects = loadResume()
        guard managedObjects?.isEmpty ?? true else {
            saveResume(address: address, objective: objective, email: email, name: name, phoneNumber: phoneNumber, photo: photo, skills: skills, yearsExperience: yearsExperience)
            return
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Resume", in: persistentContainer.viewContext) else { return }
        let context = persistentContainer.viewContext
        let resume = NSManagedObject(entity: entity, insertInto: context)
        resume.setValue(address, forKey: "address")
        resume.setValue(objective, forKey: "careerObjective")
        resume.setValue(email, forKey: "email")
        resume.setValue(phoneNumber, forKey: "phoneNumber")
        resume.setValue(photo as NSData, forKey: "photo")
        resume.setValue(String(skills.joined(separator: "|")), forKey: "skills")
        resume.setValue(Int16(yearsExperience), forKey: "totalYearsExperience")
        do {
            try context.save()
            self.resume = resume
        } catch let error as NSError {
            print("Unable to save to managed object context: \(error.localizedDescription)\n\(error.userInfo)")
        }
    }
    
    func loadResume() -> [NSManagedObject]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Resume")
        do {
            let resume = try context.fetch(fetchRequest)
            return resume
        } catch let error as NSError {
            print("Enable to fetch resume: \(error.localizedDescription)\n\(error.userInfo)")
            return nil
        }
    }

    
}
