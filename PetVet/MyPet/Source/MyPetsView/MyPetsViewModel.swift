//
//  MyPetsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import Foundation
import SwiftData

@Observable class MyPetsViewModel: Cancelable {
    
    var pets: [Pet] = []
    var managePetSheetIsShown: Bool = false
    
    init(pets: [Pet] = []) {
        print("init", "MyPetsViewModel")
        self.pets = pets
    }
    
    func fetchMyPets() {
        
    }
}

import Combine

@Observable class MyPetsDataViewModel: MyPetsViewModel {
    
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        print("init", "MyPetsDataViewModel")

        super.init()
        
        fetchMyPets()
        assignListeners()
    }
        
    
    override func fetchMyPets() {
        do {
            let descriptor = FetchDescriptor<Pet>(sortBy: [SortDescriptor(\.name)])
            pets = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    private func assignListeners() {
        NotificationManager.shared.publishersFor([.petAdded, .petDeleted, .petUpdated])
            .forEach { publisher in
                publisher
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        self?.fetchMyPets()
                    }
                    .store(in: &cancelable)
            }
    }
    
}
