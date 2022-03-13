//
//  ViewModel.swift
//  CoreDataBatchInsert
//
//  Created by Jason Anderson on 3/12/22.
//

import Foundation

final class ViewModel {
    private lazy var coreDataManager = CoreDataManager()
    
    func importData(completion: @escaping (Result<Bool, Error>) -> Void) {
        return coreDataManager.loadTestData(completion: completion)
    }
    
    func bulkImportData(completion: @escaping (Result<Bool, Error>) -> Void) {
        return coreDataManager.batchLoadTestData(completion: completion)
    }
}
