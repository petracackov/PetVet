//
//  DataSource.swift
//  MyPet
//
//  Created by Petra Cackov on 12. 7. 24.
//

import Foundation
import SwiftData

final class DataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
//    @MainActor
//    static let shared = DataSource()
    
    @MainActor
    init() {
        do {
            self.modelContainer = try ModelContainer(for: Pet.self, MedicalRecordItem.self)
            self.modelContext = modelContainer.mainContext
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
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
        return try modelContext.fetch(medicalRecordsDescriptor)
    }
    
    func delete(_ model: any PersistentModel) {
        modelContext.delete(model)
    }
    
    func insert(_ model: any PersistentModel) {
        modelContext.insert(model)
    }
    
}
