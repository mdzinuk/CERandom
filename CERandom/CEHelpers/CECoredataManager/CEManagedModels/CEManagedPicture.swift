import Foundation
import CoreData

@objc(CEManagedPicture)
open class CEManagedPicture: _CEManagedPicture {
    class func create(_ picture: Random.Person.Picture,
        managed: NSManagedObjectContext) -> CEManagedPicture? {
        let photo = CEManagedPicture(managedObjectContext: managed)
        photo?.setValue(picture.thumbnail, forKey: CEManagedPictureAttributes.thumbnail.rawValue)
        photo?.setValue(picture.large, forKey: CEManagedPictureAttributes.large.rawValue)
        return photo
    }
    func getPicture() -> Random.Person.Picture {
        return Random.Person.Picture(large: large ?? "", thumbnail: thumbnail ?? "")
    }
}
