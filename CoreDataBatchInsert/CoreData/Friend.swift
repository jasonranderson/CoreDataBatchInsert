import Foundation
import CoreData

@objc(Friend)
open class Friend: _Friend, CodableManagedObject {
	typealias EntityClass = Friend
    typealias ImportStruct = ImportData.ImportFriend
    
    static func batchInsertRequest(from items: [ImportData.ImportFriend], entity: NSEntityDescription) -> NSBatchInsertRequest {
        var index = 0
        let total = items.count
        
        let retval = NSBatchInsertRequest(entity: entity, managedObjectHandler: { (object) -> Bool in
            guard index < total else { return true }
            
            if let friend = object as? Friend {
                let friendData = items[index]
                friend.identifier = friendData.identifier
                friend.fullName = friendData.name
            }
            
            index += 1
            return false
        })
        retval.resultType = .objectIDs
        return retval
    }
    
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
