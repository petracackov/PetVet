//
//  MyPetViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 28. 6. 24.
//

import SwiftUI
import Combine

@Observable class MyPetViewModel: Cancelable {
    
    let dataSource: DataSource
    private(set) var pet: Pet
    private(set) var medicalRecords: [MedicalRecordItem] = []
    
    /// For preview
    init(dataSource: DataSource, pet: Pet, medicalRecords: [MedicalRecordItem]) {
        print("init", "MyPetViewModel")
        self.dataSource = dataSource
        self.medicalRecords = medicalRecords
        self.pet = pet
        super.init()
        
    }
    
    /// Fetches the data and assigns listeners
    convenience init(dataSource: DataSource, pet: Pet) {
        print("init", "MyPetViewModel")
        self.init(dataSource: dataSource, pet: pet, medicalRecords: [])
        self.assignListeners()
        self.fetchMyPetsMedicalRecords()
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
    
    private func fetchMyPetsMedicalRecords() {
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
