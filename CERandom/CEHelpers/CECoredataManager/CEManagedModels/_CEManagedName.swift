// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CEManagedName.swift instead.

import Foundation
import CoreData

public enum CEManagedNameAttributes: String {
    case first = "first"
    case last = "last"
    case name = "name"
    case title = "title"
}

public enum CEManagedNameRelationships: String {
    case person = "person"
}

open class _CEManagedName: CEManagedPerson {

    // MARK: - Class methods

    override open class func entityName () -> String {
        return "Name"
    }

    override open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<CEManagedName> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _CEManagedName.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var first: String?

    @NSManaged open
    var last: String?

    @NSManaged open
    var name: String?

    @NSManaged open
    var title: String?

    // MARK: - Relationships

    @NSManaged open
    var person: CEManagedPerson?

}

