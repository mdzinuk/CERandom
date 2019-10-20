// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CEManagedRandom.swift instead.

import Foundation
import CoreData

public enum CEManagedRandomRelationships: String {
    case page = "page"
    case persons = "persons"
}

open class _CEManagedRandom: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Random"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<CEManagedRandom> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _CEManagedRandom.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    // MARK: - Relationships

    @NSManaged open
    var page: CEManagedPage?

    @NSManaged open
    var persons: NSSet

    open func personsSet() -> NSMutableSet {
        return self.persons.mutableCopy() as! NSMutableSet
    }

}

extension _CEManagedRandom {

    open func  addPersons(_ objects: NSSet) {
        let mutable = self.persons.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.persons = mutable.copy() as! NSSet
    }

    open func removePersons(_ objects: NSSet) {
        let mutable = self.persons.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.persons = mutable.copy() as! NSSet
    }

    open func addPersonsObject(_ value: CEManagedPerson) {
        let mutable = self.persons.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.persons = mutable.copy() as! NSSet
    }

    open func removePersonsObject(_ value: CEManagedPerson) {
        let mutable = self.persons.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.persons = mutable.copy() as! NSSet
    }

}

