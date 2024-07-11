//
//  MyPetViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 28. 6. 24.
//

import SwiftUI
import SwiftData
import Combine

@Observable class MyPetViewModel {
    
    fileprivate(set) var pet: Pet
    fileprivate(set) var medicalRecords: [MedicalRecordItem] = []
    
    init(pet: Pet, medicalRecords: [MedicalRecordItem]) {
        print("init", "MyPetViewModel")
        self.medicalRecords = medicalRecords
        self.pet = pet
    }
    
    init(pet: Pet) {
        self.pet = pet
        print("init", "MyPetViewModel")
        fetchMyPetsMedicalRecords()
    }
    
    func fetchMyPetsMedicalRecords() {
        Task {
            medicalRecords = Array(await MockedData.getMedicalRecords().prefix(3))
        }
    }
    
}

@Observable class MyPetDataViewModel: MyPetViewModel {
    
    var modelContext: ModelContext
    private var cancelable = Set<AnyCancellable>()
    
    init(modelContext: ModelContext, pet: Pet) {
        print("init", "MyPetDataViewModel")
        self.modelContext = modelContext
        super.init(pet: pet)
        assignListeners()
    }
    
    private func fetchPet() {
        do {
            let petId = self.pet.id
            let petDescriptor = FetchDescriptor<Pet>(predicate: #Predicate { pet in
                pet.id == petId
            })
            if let pet = try modelContext.fetch(petDescriptor).first {
                self.pet = pet
            } else {
                throw NSError()
            }
        } catch {
            print("Fetch failed")
        }
    }
    
    override func fetchMyPetsMedicalRecords() {
        do {
            let petId = pet.id
            var medicalRecordsDescriptor = FetchDescriptor<MedicalRecordItem>(predicate: #Predicate { medicalRecord in
                medicalRecord.petId == petId
            })
            medicalRecordsDescriptor.fetchLimit = 3
            medicalRecords = try modelContext.fetch(medicalRecordsDescriptor)
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
                        self?.fetchPet()
                    }
                    .store(in: &cancelable)
            }
        
        NotificationManager.shared.publishersFor([.medicalRecordUpdated, .medicalRecordAdded, .medicalRecordDeleted])
            .forEach { publisher in
                publisher
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        self?.fetchMyPetsMedicalRecords()
                    }
                    .store(in: &cancelable)
            }
    }
    
}

