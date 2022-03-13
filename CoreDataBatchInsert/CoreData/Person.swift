import Foundation
import CoreData

@objc(Person)
open class Person: _Person, CodableManagedObject {
	typealias EntityClass = Person
    
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
