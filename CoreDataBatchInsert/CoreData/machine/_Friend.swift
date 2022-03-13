// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Friend.swift instead.

import Foundation
import CoreData

public enum FriendAttributes: String {
    case fullName = "fullName"
    case identifier = "identifier"
}

public enum FriendRelationships: String {
    case person = "person"
}

open class _Friend: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Friend"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Friend.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var fullName: String?

    @NSManaged open
    var identifier: String!

    // MARK: - Relationships

    @NSManaged open
    var person: Person?

}

