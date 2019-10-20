//
//  CECoreDataManager.swift
//  PagignationTable
//
//  Created by Mohammad Arafat Hossain on 19/10/19.
//  Copyright © 2019 M. Arafat. All rights reserved.
//

import CoreData

public class CECoreDataManager {
    private static var sharedCoreDataManager: CECoreDataManager = {
        let manager = CECoreDataManager()
        return manager
    }()
    private init() { }
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CERandomUsers")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private func saveContext () {
        let context = getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    class func shared() -> CECoreDataManager {
        return sharedCoreDataManager
    }
    
    private func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func storeRecords(_ random: Random) {
        DispatchQueue.main.async { [weak self] in
            if let context = self?.getContext(),
                let _ = CEManagedRandom.create(random, managed: context) {
                self?.saveContext()
            }
        }
    }
    func retrieve(from completion: @escaping(CEServiceReply<[Random.Person], CEError>) -> Void) {
        do {
            var persons: [Random.Person] = []
            let context = getContext()
            let result = try context.fetch(CEManagedPerson.buildRequest())
            for managedPerson in result {
                print(managedPerson.getPerson() ?? "")
                if let person = managedPerson.getPerson() {
                    persons.append(person)
                }
            }
            completion(CEServiceReply.success(persons))
        } catch {
            completion(CEServiceReply.failure(CEError.coredata))
        }
    }
    
    func deleteRecords() {
        DispatchQueue.main.async { [weak self] in
            if let context = self?.getContext() {
                let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: CEManagedRandom.entityName())
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

                do {
                    try context.execute(deleteRequest)
                    self?.saveContext()
                } catch {
                    print ("There was an error")
                }
            }
        }
    }
}


