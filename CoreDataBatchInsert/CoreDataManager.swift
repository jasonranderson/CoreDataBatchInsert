//
//  CoreDataManager.swift
//  CoreDataBatchInsert
//
//  Created by Jason Anderson on 3/12/22.
//

import Foundation
import CoreData
import Combine

public final class CoreDataManager {
    private let container = NSPersistentContainer(name: "Model")
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func performInBackground(_ block: @escaping (NSManagedObjectContext) -> Void) {
        container.performBackgroundTask(block)
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        guard context.hasChanges else {
            return
        }
        try? context.save()
    }
    
    func loadTestData(completion: @escaping (Result<Bool, Error>) -> Void) {
        performInBackground { context in
            context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy //overwrite existing data with new data
            
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
            guard let dataUrl = Bundle.main.url(forResource: "data", withExtension: "json"),
                  let data = try? Data(contentsOf: dataUrl),
                  let _ = try? decoder.decode([Person].self, from: data) else {
                      DispatchQueue.main.async {
                          completion(Result.failure(NSError()))
                      }
                      return
                  }
            
            self.saveContext(context)
            DispatchQueue.main.async {
                completion(Result.success(true))
            }
        }
    }
    
    func batchLoadTestData(completion: @escaping (Result<Bool, Error>) -> Void) {
        performInBackground { context in
            context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            
            let decoder = JSONDecoder()
            guard let dataUrl = Bundle.main.url(forResource: "data", withExtension: "json"),
                  let data = try? Data(contentsOf: dataUrl) else {
                      DispatchQueue.main.async {
                          completion(Result.failure(NSError(domain: "domain", code: 1, userInfo: [NSLocalizedDescriptionKey: "couldn't open data file"])))
                      }
                      return
                  }
            do {
                let importItems = try decoder.decode([ImportData].self, from: data)
                let personBatch = Person.batchInsertRequest(from: importItems, entity: Person.entity())
                
                if let result = try context.execute(personBatch) as? NSBatchInsertResult,
                   let objectIDs = result.result as? [NSManagedObjectID] {
                    
                    let people = try context.existingManagedObjectsWithIDs(Person.self, objectIDs: objectIDs)
                    for person in people {
                        if let personData = importItems.first(where: {$0.identifier == person.identifier}) {
                            let friendBatch = Friend.batchInsertRequest(from: personData.friends, entity: Friend.entity())
                            if let friendResult = try context.execute(friendBatch) as? NSBatchInsertResult,
                               let friendObjectIds = friendResult.result as? [NSManagedObjectID] {
                                
                                let friendObjects = try context.existingManagedObjectsWithIDs(Friend.self, objectIDs: friendObjectIds)
                                person.addFriends(NSSet(array: friendObjects))
                            }
                        }
                    }
                    
                }
                
                self.saveContext(context)
                
                DispatchQueue.main.async {
                    completion(Result.success(true))
                }
                
            } catch let error {
                DispatchQueue.main.async {
                    completion(Result.failure(error))
                }
            }
        }
    }
    
    init() {
        container.loadPersistentStores { description, error in
            if error == nil {
                var values = URLResourceValues()
                values.isExcludedFromBackup = true
                try? description.url?.setResourceValues(values)
            }
        }
    }
}

struct ImportData: Decodable {
    struct ImportTag: Decodable {
        let name: String

        enum CodingKeys: String, CodingKey {
            case name
        }
        
        func toDictionary() -> [String: String] {
            return ["name": name]
        }
    }

    struct ImportFriend: Decodable {
        let identifier: String
        let name: String

        enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case name
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            identifier = try container.decode(String.self, forKey: .identifier)
            name = try container.decode(String.self, forKey: .name)
        }
        
        func toDictionary() -> [String: Any] {
            return ["fullName": name, "identifier": identifier]
        }
    }
    
    let identifier: String
    let isActive: Bool
    let picture: String
    let age: Int
    let eyeColor: String
    let name: String
    let gender: String
    let company: String
    let email: String
    let phone: String
    let address: String
    let about: String
    let tags: [ImportTag]
    let friends: [ImportFriend]
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case isActive, picture, age, eyeColor, name, gender, company, email, phone, address, about, tags, friends
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        picture = try container.decode(String.self, forKey: .picture)
        age = try container.decode(Int.self, forKey: .age)
        eyeColor = try container.decode(String.self, forKey: .eyeColor)
        name = try container.decode(String.self, forKey: .name)
        gender = try container.decode(String.self, forKey: .gender)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        phone = try container.decode(String.self, forKey: .phone)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        tags = try container.decode([ImportTag].self, forKey: .tags)
        friends = try container.decode([ImportFriend].self, forKey: .friends)
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "identifier": identifier,
            "isActive": isActive,
            "picturePath": picture,
            "age": age,
            "eyeColor": eyeColor,
            "fullName": name,
            "gender": gender,
            "company": company,
            "email": email,
            "phone": phone,
            "address": address,
            "summary": about,
            "friends": friends.map { $0.toDictionary() },
            "tags": tags.map { $0.toDictionary() }
        ]
    }
}
