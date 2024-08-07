//
//  ManagePetViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 1. 7. 24.
//

import SwiftUI
import _PhotosUI_SwiftUI

@Observable class ManagePetViewModel {
    
    private let dataService: DataService
    private let pet: Pet?
    var name: String
    var species: Pet.Species
    var gender: Pet.Gender
    var image: UIImage?
    var photoPickerItem: PhotosPickerItem?
    var date: Date
    var cameraAccessGranted: Bool = false
    
    var isEditMode: Bool {
        pet != nil
    }
    
    init(dataService: DataService, pet: Pet?) {
        print("init", "ManagePetViewModel")
        self.pet = pet
        self.dataService = dataService
        name = pet?.name ?? ""
        species = pet?.species ?? .unknown
        image = pet?.image
        gender = pet?.gender ?? .unknown
        date = pet?.birthDate ?? Date()
        checkCameraAccess()
    }
        
    func savePet() {
        if let pet {
            dataService.updatePet(pet, name: name, species: species, image: image, birthDate: date)
        } else if !name.isEmpty {
            dataService.createPet(name: name, species: species, image: image, gender: gender, birthDate: date)
        } else {
            AppError.handle(NSError())
        }
    }
    
    func deletePet() {
        guard let pet else { return }
        dataService.deletePet(pet)
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
                AppError.handle(error)
            }
        }
    }
    
    private func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied, .restricted:
            cameraAccessGranted = false
        case .authorized:
            cameraAccessGranted = true
        case .notDetermined:
            Task {
                let granted = await AVCaptureDevice.requestAccess(for: .video)
                await MainActor.run {
                    self.cameraAccessGranted = granted
                }
            }
        @unknown default:
            cameraAccessGranted = false
        }
    }
    
}
