// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CEManagedPage.swift instead.

import Foundation
import CoreData

public enum CEManagedPageAttributes: String {
    case items = "items"
    case number = "number"
}

public enum CEManagedPageRelationships: String {
    case random = "random"
}

open class _CEManagedPage: CEManagedRandom {

    // MARK: - Class methods

    override open class func entityName () -> String {
        return "Page"
    }

    override open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<CEManagedPage> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _CEManagedPage.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var items: Int32 // Optional scalars not supported

    @NSManaged open
    var number: Int32 // Optional scalars not supported

    // MARK: - Relationships

    @NSManaged open
    var random: CEManagedRandom?

}

