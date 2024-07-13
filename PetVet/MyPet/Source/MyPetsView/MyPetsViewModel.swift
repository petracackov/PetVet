//
//  MyPetsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import Foundation

@Observable class MyPetsViewModel: Cancelable {
    
    let dataSource: DataSource
    private(set) var pets: [Pet] = []
    
    /// For preview
    init(pets: [Pet], dataSource: DataSource) {
        print("init", "MyPetsViewModel")
        self.pets = pets
        self.dataSource = dataSource
        super.init()
    }
    
    /// Fetches the data and assigns listeners
    convenience init(dataSource: DataSource) {
        print("init", "MyPetsViewModel")
        self.init(pets: [], dataSource: dataSource)
        
        fetchMyPets()
        assignListeners()
    }
    
    func fetchMyPets() {
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
