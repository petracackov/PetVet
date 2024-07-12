//
//  MyPetViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 28. 6. 24.
//

import SwiftUI
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
    
    var dataSource: DataSource
    private var cancelable = Set<AnyCancellable>()
    
    init(dataSource: DataSource, pet: Pet) {
        print("init", "MyPetDataViewModel")
        self.dataSource = dataSource
        super.init(pet: pet)
        assignListeners()
    }
    
    private func fetchPet() {
        do {
            let petId = self.pet.id
            let pets = try dataSource.fetch(type: Pet.self, predicate: #Predicate { pet in
                pet.id == petId
            })
            if let pet = pets.first {
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
            self.medicalRecords = try dataSource.fetch(type: MedicalRecordItem.self, fetchLimit: 3, predicate: #Predicate { medicalRecord in
                medicalRecord.petId == petId
            })
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

