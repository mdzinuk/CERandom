import Foundation
import CoreData

@objc(CEManagedRandom)
open class CEManagedRandom: _CEManagedRandom {
	class func create(_ random: Random,
                      managed: NSManagedObjectContext) -> CEManagedRandom? {
        let obj = CEManagedRandom(managedObjectContext: managed)
        
        var array = [CEManagedPerson]()
        for user in random.persons {
            if let person = CEManagedPerson.create(user, managed: managed) {
                array.append(person)
            }
        }
        obj?.addPersons(NSSet(array: array))
        obj?.page = CEManagedPage.create(random.page, managed: managed)
        return obj
    }
}
