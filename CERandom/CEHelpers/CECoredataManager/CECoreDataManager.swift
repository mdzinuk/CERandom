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
                print("\(CEError.coredata.localizedDescription) \(error.userInfo)")
            }
        })
        return container
    }()
    class func shared() -> CECoreDataManager {
        return sharedCoreDataManager
    }
    
    private func saveContext () {
        let context = getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(CEError.coredata.localizedDescription)
            }
        }
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
            let context = getContext()
            let result = try context.fetch(CEManagedPerson.buildRequest())
            completion(CEServiceReply.success(result.compactMap{ $0.getPerson() }))
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
                    print(CEError.coredata.localizedDescription)
                }
            }
        }
    }
}


