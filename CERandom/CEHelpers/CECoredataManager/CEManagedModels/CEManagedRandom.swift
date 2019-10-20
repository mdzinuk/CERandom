import Foundation
import CoreData

@objc(CEManagedRandom)
open class CEManagedRandom: _CEManagedRandom {
	// Custom logic goes here.
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
    
    static func buildRequest() -> NSFetchRequest<CEManagedRandom> {
        let request = NSFetchRequest(entityName: CEManagedRandom.entityName()) as NSFetchRequest<CEManagedRandom>

        request.relationshipKeyPathsForPrefetching = ["persons", "page"]
        return request
    }
    
    func getRandom() -> Random? {
        if let managedPersons = self.personsSet().allObjects as? [CEManagedPerson], let page = page as? Random.Page {
            var persons = [Random.Person]()
            managedPersons.forEach { (managedPerson: CEManagedPerson) in
                if let person = managedPerson.getPerson() {
                    persons.append(person)
                }
            }
            return Random(persons: persons, page: page)
        }
        return nil
    }
}
