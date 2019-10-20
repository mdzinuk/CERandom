import Foundation
import CoreData

@objc(CEManagedName)
open class CEManagedName: _CEManagedName {
	class func create(_ personName: Random.Person.Name,
        managed: NSManagedObjectContext) -> CEManagedName? {
        let name = CEManagedName(managedObjectContext: managed)
        name?.setValue(personName.title, forKey: CEManagedNameAttributes.first.rawValue)
        name?.setValue(personName.first, forKey: CEManagedNameAttributes.first.rawValue)
        name?.setValue(personName.last, forKey: CEManagedNameAttributes.last.rawValue)
        return name
    }
    
    func getName() -> Random.Person.Name {
        return Random.Person.Name(title: title ?? "", first: first ?? "", last: last ?? "")
    }
}
