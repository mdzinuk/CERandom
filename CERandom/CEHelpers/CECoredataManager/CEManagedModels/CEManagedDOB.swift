import Foundation
import CoreData

@objc(CEManagedDOB)
open class CEManagedDOB: _CEManagedDOB {
	// Custom logic goes here.
    class func create(_ dateOfBirth: Random.Person.Dob,
        managed: NSManagedObjectContext) -> CEManagedDOB? {
        
        let dob = CEManagedDOB(managedObjectContext: managed)
        dob?.setValue(dateOfBirth.age, forKey: CEManagedDOBAttributes.age.rawValue)
        dob?.setValue(dateOfBirth.date, forKey: CEManagedDOBAttributes.date.rawValue)
        return dob
    }
    func getDob() -> Random.Person.Dob {
        return Random.Person.Dob(date: date ?? Date(), age: 0.0)
    }
}
