//
//  MyPetsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import Foundation

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
    
    var dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
        print("init", "MyPetsDataViewModel")

        super.init()
        
        fetchMyPets()
        assignListeners()
    }
        
    
    override func fetchMyPets() {
        do {
            pets = try dataSource.fetch(type: Pet.self, sortBy: [SortDescriptor(\.name)])
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
