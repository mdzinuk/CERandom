import Foundation
import CoreData

@objc(CEManagedPage)
open class CEManagedPage: _CEManagedPage {
	class func create(_ value: Random.Page,
        managed: NSManagedObjectContext) -> CEManagedPage? {
        let page = CEManagedPage(managedObjectContext: managed)
        page?.setValue(value.items, forKey: "items")
        page?.setValue(value.number, forKey: "number")
        return page
    }
    
    func getPage() -> Random.Page {
        return Random.Page(items: Int(items), number: Int(number))
    }
}
