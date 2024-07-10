//
//  MyPetsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import Foundation
import SwiftData

@Observable class MyPetsViewModel {
    
    var pets: [Pet] = []
    var managePetSheetIsShown: Bool = false
    
    init(pets: [Pet] = []) {
        print("init", "MyPetsViewModel")
        self.pets = pets
        self.managePetSheetIsShown = managePetSheetIsShown
    }
    
    func fetchMyPets() {
        
    }
}

@Observable class MyPetsDataViewModel: MyPetsViewModel {
    
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        print("init", "MyPetsDataViewModel")

        super.init()
        
        fetchMyPets()
        addObservers()
    }
        
    
    override func fetchMyPets() {
        do {
            let descriptor = FetchDescriptor<Pet>(sortBy: [SortDescriptor(\.name)])
            pets = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    private func addObservers() {
        NotificationManager.shared.addObserverFor(.petAdded, selector: #selector(updateData))
        NotificationManager.shared.addObserverFor(.petDeleted, selector: #selector(updateData))
        NotificationManager.shared.addObserverFor(.petUpdated, selector: #selector(updateData))
    }
    
    @objc func updateData() {
        fetchMyPets()
    }
    
}
