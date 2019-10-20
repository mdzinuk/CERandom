// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CEManagedPicture.swift instead.

import Foundation
import CoreData

public enum CEManagedPictureAttributes: String {
    case large = "large"
    case thumbnail = "thumbnail"
}

public enum CEManagedPictureRelationships: String {
    case person = "person"
}

open class _CEManagedPicture: CEManagedPerson {

    // MARK: - Class methods

    override open class func entityName () -> String {
        return "Picture"
    }

    override open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<CEManagedPicture> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _CEManagedPicture.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var large: String?

    @NSManaged open
    var thumbnail: String?

    // MARK: - Relationships

    @NSManaged open
    var person: CEManagedPerson?

}

