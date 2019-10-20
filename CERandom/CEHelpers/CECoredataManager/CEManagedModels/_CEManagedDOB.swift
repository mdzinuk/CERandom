// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CEManagedDOB.swift instead.

import Foundation
import CoreData

public enum CEManagedDOBAttributes: String {
    case age = "age"
    case date = "date"
}

public enum CEManagedDOBRelationships: String {
    case person = "person"
}

open class _CEManagedDOB: CEManagedPerson {

    // MARK: - Class methods

    override open class func entityName () -> String {
        return "DOB"
    }

    override open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<CEManagedDOB> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _CEManagedDOB.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var age: Double // Optional scalars not supported

    @NSManaged open
    var date: Date?

    // MARK: - Relationships

    @NSManaged open
    var person: CEManagedPerson?

}

