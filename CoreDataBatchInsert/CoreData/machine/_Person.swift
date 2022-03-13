// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.swift instead.

import Foundation
import CoreData

public enum PersonAttributes: String {
    case address = "address"
    case age = "age"
    case company = "company"
    case email = "email"
    case eyeColor = "eyeColor"
    case fullName = "fullName"
    case gender = "gender"
    case identifier = "identifier"
    case isActive = "isActive"
    case phone = "phone"
    case picturePath = "picturePath"
    case summary = "summary"
}

public enum PersonRelationships: String {
    case friends = "friends"
    case tags = "tags"
}

open class _Person: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Person"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Person.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var address: String?

    @NSManaged open
    var age: Int32 // Optional scalars not supported

    @NSManaged open
    var company: String?

    @NSManaged open
    var email: String?

    @NSManaged open
    var eyeColor: String?

    @NSManaged open
    var fullName: String?

    @NSManaged open
    var gender: String?

    @NSManaged open
    var identifier: String!

    @NSManaged open
    var isActive: Bool // Optional scalars not supported

    @NSManaged open
    var phone: String?

    @NSManaged open
    var picturePath: String?

    @NSManaged open
    var summary: String?

    // MARK: - Relationships

    @NSManaged open
    var friends: NSSet

    open func friendsSet() -> NSMutableSet {
        return self.friends.mutableCopy() as! NSMutableSet
    }

    @NSManaged open
    var tags: NSSet

    open func tagsSet() -> NSMutableSet {
        return self.tags.mutableCopy() as! NSMutableSet
    }

}

extension _Person {

    open func addFriends(_ objects: NSSet) {
        let mutable = self.friends.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.friends = mutable.copy() as! NSSet
    }

    open func removeFriends(_ objects: NSSet) {
        let mutable = self.friends.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.friends = mutable.copy() as! NSSet
    }

    open func addFriendsObject(_ value: Friend) {
        let mutable = self.friends.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.friends = mutable.copy() as! NSSet
    }

    open func removeFriendsObject(_ value: Friend) {
        let mutable = self.friends.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.friends = mutable.copy() as! NSSet
    }

}

extension _Person {

    open func addTags(_ objects: NSSet) {
        let mutable = self.tags.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.tags = mutable.copy() as! NSSet
    }

    open func removeTags(_ objects: NSSet) {
        let mutable = self.tags.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.tags = mutable.copy() as! NSSet
    }

    open func addTagsObject(_ value: Tag) {
        let mutable = self.tags.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.tags = mutable.copy() as! NSSet
    }

    open func removeTagsObject(_ value: Tag) {
        let mutable = self.tags.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.tags = mutable.copy() as! NSSet
    }

}

