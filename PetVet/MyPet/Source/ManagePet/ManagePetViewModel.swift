//
//  ManagePetViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 1. 7. 24.
//

import SwiftUI
import _PhotosUI_SwiftUI

@Observable class ManagePetViewModel: ViewModel {
    
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
        super.init()
        checkCameraAccess()
    }
        
    func savePet() {
        do {
            if let pet {
                dataService.updatePet(pet, name: name, species: species, image: image, birthDate: date)
            } else if !name.isEmpty {
                try dataService.createPet(name: name, species: species, image: image, gender: gender, birthDate: date)
            } else {
                handleError(.validationFailed)
            }
        } catch {
            handleError(error)
        }
    }
    
    func deletePet() {
        guard let pet else { return }
        do {
            try dataService.deletePet(pet)
        } catch {
            handleError(error)
        }
            
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
                handleError(error)
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
