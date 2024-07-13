//
//  ManagePetViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 1. 7. 24.
//

import SwiftUI
import _PhotosUI_SwiftUI

@Observable class ManagePetViewModel {
    
    private var dataSource: DataSource
    private let pet: Pet?
    var name: String
    var species: Pet.Species
    var image: UIImage?
    var photoPickerItem: PhotosPickerItem?
    
    var isEditMode: Bool {
        pet != nil
    }
    
    init(dataSource: DataSource, pet: Pet?) {
        print("init", "ManagePetViewModel")
        self.pet = pet
        self.dataSource = dataSource
        name = pet?.name ?? ""
        species = pet?.species ?? .unknown
        image = pet?.image
    }
        
    func savePet() {
        if let pet {
            pet.name = name
            pet.species = species
            pet.image = image
            let notificationData = PetNotificationId(id: pet.id)
            NotificationManager.shared.postNotification(.petUpdated, data: try? notificationData.dictionary())
        } else if !name.isEmpty {
            let id = UUID().uuidString
            let pet = Pet(id: id, name: name, species: species, image: image)
            dataSource.insert(pet)
            let notificationData = PetNotificationId(id: id)
            NotificationManager.shared.postNotification(.petAdded, data: try? notificationData.dictionary())
        } else {
            // TODO: handle error
            print("No data error")
        }
    }
    
    func deletePet() {
        guard let pet else { return }
        dataSource.delete(pet)
        let notificationData = PetNotificationId(id: pet.id)
        NotificationManager.shared.postNotification(.petDeleted, data: try? notificationData.dictionary())
    }
    
    func onImageSelected(_ imageItem: PhotosPickerItem) {
        Task {
            do {
                if let data = try await imageItem.loadTransferable(type: Data.self) {
                    await MainActor.run {
                        self.image = UIImage(data: data)
                    }
                } else {
                    throw NSError()
                }
            } catch {
                // TODO: handle error
                print("error")
            }
        }
    }
    
}
