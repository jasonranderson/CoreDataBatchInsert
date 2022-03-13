//
//  NSManagedObjectContext+Extensions.swift
//  CoreDataBatchInsert
//
//  Created by Jason Anderson on 3/12/22.
//

import Baxter

extension NSManagedObjectContext {
    func fetchEntityWithIdentifier<T: CodableManagedObject>(_ entityType: T.Type, _ identifier: Int32, key: String) -> T? {
        guard let entityName = T.EntityClass.entity().name else {
            fatalError("entityName for \(T.self) must be non-nil!")
        }
        
        let retval = self.kba_fetch(options: [.entityName: entityName, .predicate: NSPredicate(format: "%K == %d", key, identifier), .fetchLimit: 1]).first as? T
        
        return retval
    }
    func createEntityWithIdentifier<T: CodableManagedObject>(_ entityType: T.Type, _ identifier: Int32, key: String, decoder: JSONDecoder, data: Data) throws -> T {
        let retval = try decoder.decode(T.self, from: data)
        
        return retval
    }
    func fetchOrCreateEntityWithIdentifier<T: CodableManagedObject>(_ entityType: T.Type, _ identifier: Int32, key: String, decoder: JSONDecoder, data: Data) throws -> T {
        guard let retval: T = self.fetchEntityWithIdentifier(entityType, identifier, key: key) else {
            return try self.createEntityWithIdentifier(entityType, identifier, key: key, decoder: decoder, data: data)
        }
        
        var mutableRetval = retval
        try decoder.update(&mutableRetval, from: data)
        
        return mutableRetval
    }
    
    func fetchEntityWithIdentifier<T: CodableManagedObject>(_ entityType: T.Type, _ identifier: String, key: String) -> T? {
        guard let entityName = T.EntityClass.entity().name else {
            fatalError("entityName for \(T.self) must be non-nil!")
        }
        
        let retval = self.kba_fetch(options: [.entityName: entityName, .predicate: NSPredicate(format: "%K == %@", key, identifier), .fetchLimit: 1]).first as? T
        
        return retval
    }
    func createEntityWithIdentifier<T: CodableManagedObject>(_ entityType: T.Type, _ identifier: String, key: String, decoder: JSONDecoder, data: Data) throws -> T {
        let retval = try decoder.decode(T.self, from: data)
        
        return retval
    }
    func fetchOrCreateEntityWithIdentifier<T: CodableManagedObject>(_ entityType: T.Type, _ identifier: String, key: String, decoder: JSONDecoder, data: Data) throws -> T {
        guard let retval: T = self.fetchEntityWithIdentifier(entityType, identifier, key: key) else {
            return try self.createEntityWithIdentifier(entityType, identifier, key: key, decoder: decoder, data: data)
        }
        
        var mutableRetval = retval
        try decoder.update(&mutableRetval, from: data)
        
        return mutableRetval
    }
    
    func deleteAll<T: NSManagedObject>(_ entityClass: T.Type) {
        guard let entityName = T.entity().name else {
            fatalError("entityName for \(T.self) must be non-nil!")
        }
        
        let options: [KBANSFetchRequestOptionsKey: Any] = [
            .entityName: entityName,
            .includesPropertyValues: false
        ]
        
        var deleted = 0
        
        for case let entity as NSManagedObject in self.kba_fetch(options: options) {
            self.delete(entity)
            deleted += 1
        }
    }
}
