// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CEManagedPerson.swift instead.

import Foundation
import CoreData

public enum CEManagedPersonAttributes: String {
    case email = "email"
    case gender = "gender"
    case nat = "nat"
}

public enum CEManagedPersonRelationships: String {
    case dob = "dob"
    case picture = "picture"
    case rName = "rName"
    case random = "random"
}

open class _CEManagedPerson: CEManagedRandom {

    // MARK: - Class methods

    override open class func entityName () -> String {
        return "Person"
    }

    override open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<CEManagedPerson> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _CEManagedPerson.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var email: String?

    @NSManaged open
    var gender: String?

    @NSManaged open
    var nat: String?

    // MARK: - Relationships

    @NSManaged open
    var dob: CEManagedDOB?

    @NSManaged open
    var picture: CEManagedPicture?

    @NSManaged open
    var rName: CEManagedName?

    @NSManaged open
    var random: CEManagedRandom?

}

