// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Tag.swift instead.

import Foundation
import CoreData

public enum TagAttributes: String {
    case name = "name"
}

public enum TagRelationships: String {
    case people = "people"
}

open class _Tag: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Tag"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Tag.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var name: String!

    // MARK: - Relationships

    @NSManaged open
    var people: NSSet

    open func peopleSet() -> NSMutableSet {
        return self.people.mutableCopy() as! NSMutableSet
    }

}

extension _Tag {

    open func addPeople(_ objects: NSSet) {
        let mutable = self.people.mutableCopy() as! NSMutableSet
        mutable.union(objects as Set<NSObject>)
        self.people = mutable.copy() as! NSSet
    }

    open func removePeople(_ objects: NSSet) {
        let mutable = self.people.mutableCopy() as! NSMutableSet
        mutable.minus(objects as Set<NSObject>)
        self.people = mutable.copy() as! NSSet
    }

    open func addPeopleObject(_ value: Person) {
        let mutable = self.people.mutableCopy() as! NSMutableSet
        mutable.add(value)
        self.people = mutable.copy() as! NSSet
    }

    open func removePeopleObject(_ value: Person) {
        let mutable = self.people.mutableCopy() as! NSMutableSet
        mutable.remove(value)
        self.people = mutable.copy() as! NSSet
    }

}

