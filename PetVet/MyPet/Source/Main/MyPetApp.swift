//
//  MyPetApp.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import SwiftUI
import SwiftData

@main
struct MyPetApp: App {
    
    var body: some Scene {
        WindowGroup {
            DashboardScreen(viewModel: .init(modelContext: ItemDataSource.shared.modelContext))
        }
    }
}

final class ItemDataSource {
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    @MainActor
    static let shared = ItemDataSource()
    
    @MainActor
    private init() {
        do {
            self.modelContainer = try ModelContainer(for: Pet.self, MedicalRecordItem.self)
            self.modelContext = modelContainer.mainContext
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
}
