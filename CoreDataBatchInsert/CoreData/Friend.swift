import Foundation
import CoreData

@objc(Friend)
open class Friend: _Friend, CodableManagedObject {
	typealias EntityClass = Friend
    
    enum CodingKeys: String, CodingKey {
        case id, name
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
    
    private func assignValues(container: KeyedDecodingContainer<Friend.CodingKeys>, context _: NSManagedObjectContext) throws {
        identifier = try container.decode(String.self, forKey: .id)
        fullName = try container.decode(String.self, forKey: .name)
    }
}
