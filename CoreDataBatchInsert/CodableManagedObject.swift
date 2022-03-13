//
//  CodableManagedObject.swift
//  CoreDataBatchInsert
//
//  Created by Jason Anderson on 3/12/22.
//

import CoreData

protocol CodableManagedObject: Codable, DecoderUpdatable {
    associatedtype EntityClass: NSManagedObject
}
