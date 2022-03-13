import Foundation
import CoreData

@objc(Person)
open class Person: _Person, CodableManagedObject {
	typealias EntityClass = Person
    typealias ImportStruct = ImportData
    
    
    static func batchInsertRequest(from items: [ImportData], entity: NSEntityDescription) -> NSBatchInsertRequest {
        var index = 0
        let total = items.count
        
        let retval = NSBatchInsertRequest(entity: entity, managedObjectHandler: { (object) -> Bool in
            guard index < total else { return true }
            
            if let person = object as? Person {
                let personData = items[index]
                person.identifier = personData.identifier
                person.isActive = personData.isActive
                person.picturePath = personData.picture
                person.age = Int32(personData.age)
                person.eyeColor = personData.eyeColor
                person.fullName = personData.name
                person.gender = personData.gender
                person.company = personData.company
                person.email = personData.email
                person.phone = personData.phone
                person.address = personData.address
                person.summary = personData.about
            }
            
            index += 1
            return false
        })
        retval.resultType = .objectIDs
        return retval
    }
    
    enum CodingKeys: String, CodingKey {
        case id, isActive, picture, age, eyeColor, name, gender, company, email, phone, address, about, tags, friends
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw NSError()
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try assignValues(container: container, context: context)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .id)
    }
    
    func update(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw NSError()
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try assignValues(container: container, context: context)
    }
    
    private func assignValues(container: KeyedDecodingContainer<Person.CodingKeys>, context: NSManagedObjectContext) throws {
        identifier = try container.decode(String.self, forKey: .id)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        picturePath = try container.decode(String.self, forKey: .picture)
        age = try container.decode(Int32.self, forKey: .age)
        eyeColor = try container.decode(String.self, forKey: .eyeColor)
        fullName = try container.decode(String.self, forKey: .name)
        gender = try container.decode(String.self, forKey: .gender)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        phone = try container.decode(String.self, forKey: .phone)
        address = try container.decode(String.self, forKey: .address)
        summary = try container.decode(String.self, forKey: .about)
        
        if let friends = try container.decodeIfPresent([Friend].self, forKey: .friends) {
            addFriends(NSSet(array: friends))
        }

        if let tags = try container.decodeIfPresent([Tag].self, forKey: .tags) {
            addTags(NSSet(array: tags))
        }
    }
}
