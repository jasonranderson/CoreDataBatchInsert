import Foundation
import CoreData

@objc(Tag)
open class Tag: _Tag, CodableManagedObject {
	typealias EntityClass = Tag
    typealias ImportStruct = ImportData.ImportTag
    
    static func batchInsertRequest(from items: [ImportData.ImportTag], entity: NSEntityDescription) -> NSBatchInsertRequest {
        var index = 0
        let total = items.count
        
        let retval = NSBatchInsertRequest(entity: entity, managedObjectHandler: { (object) -> Bool in
            guard index < total else { return true }
            
            if let tag = object as? Tag {
                let tagData = items[index]
                tag.name = tagData.name
            }
            
            index += 1
            return false
        })
        retval.resultType = .objectIDs
        return retval
    }
    
    enum CodingKeys: String, CodingKey {
        case name
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
        try container.encode(name, forKey: .name)
    }
    
    func update(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw NSError()
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try assignValues(container: container, context: context)
    }
    
    private func assignValues(container: KeyedDecodingContainer<Tag.CodingKeys>, context _: NSManagedObjectContext) throws {
        name = try container.decode(String.self, forKey: .name)
    }
}
