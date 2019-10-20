import Foundation
import CoreData

@objc(CEManagedPerson)
open class CEManagedPerson: _CEManagedPerson {
    class func create(_ man: Random.Person, managed: NSManagedObjectContext) -> CEManagedPerson? {
        let person = CEManagedPerson(managedObjectContext: managed)
        person?.setValue(man.email, forKey: CEManagedPersonAttributes.email.rawValue)
        person?.setValue(man.gender, forKey: CEManagedPersonAttributes.gender.rawValue)
        person?.setValue(man.nat, forKey: CEManagedPersonAttributes.nat.rawValue)
        
        
        let dob = CEManagedDOB.create(man.dob, managed: managed)
        let picture = CEManagedPicture.create(man.picture, managed: managed)
        let name = CEManagedName.create(man.name, managed: managed)
        
        person?.setValue(dob, forKey: CEManagedPersonRelationships.dob.rawValue)
        person?.setValue(picture, forKey: CEManagedPersonRelationships.picture.rawValue)
        person?.setValue(name, forKey: CEManagedPersonRelationships.rName.rawValue)
        return person
    }
    
    static func buildRequest() -> NSFetchRequest<CEManagedPerson> {
        return CEManagedPerson.fetchRequest()
    }
    
    func getPerson() -> Random.Person? {
        guard let name = rName?.getName(),
            let dob = dob?.getDob(),
            let pic = picture?.getPicture() else { return nil }
        return Random.Person(gender: gender, nat: nat,
                             email: email, name: name,
                             dob: dob, picture: pic)
    }
}
