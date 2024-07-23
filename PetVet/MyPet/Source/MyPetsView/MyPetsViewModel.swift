//
//  MyPetsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import Foundation

@Observable class MyPetsViewModel: Cancelable {
    
    let dataService: DataService
    private(set) var pets: [Pet] = []
    var selectedPet: Pet?
    
    /// For preview
    init(pets: [Pet], dataService: DataService) {
        print("init", "MyPetsViewModel")
        self.pets = pets
        self.dataService = dataService
        super.init()
    }
    
    /// Fetches the data and assigns listeners
    convenience init(dataService: DataService) {
        print("init", "MyPetsViewModel")
        self.init(pets: [], dataService: dataService)
        
        fetchMyPets()
        assignListeners()
    }
    
    func fetchMyPets() {
        do {
            self.pets = try dataService.fetchMyPets()
        } catch {
            AppError.handle(error)
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
