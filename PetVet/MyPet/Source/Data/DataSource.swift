//
//  DataSource.swift
//  MyPet
//
//  Created by Petra Cackov on 12. 7. 24.
//

import Foundation
import SwiftData

final class DataSource {
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    @MainActor
    static let shared = DataSource()
    
    @MainActor
    init() {
        do {
            self.modelContainer = try ModelContainer(for: Pet.self, MedicalRecordItem.self, PetEvent.self, VetInfo.self)
            self.modelContext = modelContainer.mainContext
        } catch {
            fatalError("Failed to create ModelContainer. \(error)")
        }
    }
    
    func fetch<Item: PersistentModel>(type: Item.Type,
                                      fetchLimit: Int? = nil,
                                      predicate: Predicate<Item>? = nil,
                                      sortBy: [SortDescriptor<Item>]? = nil) throws -> [Item] {
        var medicalRecordsDescriptor = FetchDescriptor<Item>(
            predicate: predicate,
            sortBy: sortBy ?? [])
        medicalRecordsDescriptor.fetchLimit = fetchLimit
        do {
            return try modelContext.fetch(medicalRecordsDescriptor)
        } catch {
            throw AppError.dataSource(error)
        }
    }
    
    func delete(_ model: any PersistentModel) throws {
        modelContext.delete(model)
        try saveData()
    }
    
    func insert(_ model: any PersistentModel) throws {
        modelContext.insert(model)
        try saveData()
    }
    
    func saveData() throws {
        do {
            try modelContext.save()
        } catch {
            throw AppError.savingDataFailed
        }
        
    }
    
}
