//
//  ManagePetViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 1. 7. 24.
//

import SwiftUI

@Observable class ManagePetViewModel {
    
    let pet: Pet?
    var name: String
    var species: Pet.Species
    
    init(pet: Pet?) {
        print("init", "ManagePetViewModel")
        self.pet = pet
        name = pet?.name ?? ""
        species = pet?.species ?? .unknown
    }
    
    func savePet() {
        
    }
    
    func deletePet() {
        
    }
    
}

@Observable class ManagePetDataViewModel: ManagePetViewModel {
    
    private var dataSource: DataSource
    
    init(dataSource: DataSource, pet: Pet?) {
        print("init", "ManagePetDataViewModel")
        self.dataSource = dataSource
        super.init(pet: pet)
    }
        
    
    override func savePet() {
        if let pet {
            pet.name = name
            pet.species = species
            let notificationData = PetNotificationId(id: pet.id)
            NotificationManager.shared.postNotification(.petUpdated, data: try? notificationData.dictionary())
        } else if !name.isEmpty {
            let id = UUID().uuidString
            let pet = Pet(id: id, name: name, species: species, image: UIImage())
            dataSource.insert(pet)
            let notificationData = PetNotificationId(id: id)
            NotificationManager.shared.postNotification(.petAdded, data: try? notificationData.dictionary())
        } else {
            // TODO: handle error
            print("No data error")
        }
    }
    
    override func deletePet() {
        guard let pet else { return }
        dataSource.delete(pet)
        let notificationData = PetNotificationId(id: pet.id)
        NotificationManager.shared.postNotification(.petDeleted, data: try? notificationData.dictionary())
    }
}
