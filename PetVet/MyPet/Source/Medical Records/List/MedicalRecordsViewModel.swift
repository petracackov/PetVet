//
//  MedicalRecordsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 2. 7. 24.
//

import SwiftUI

@Observable class MedicalRecordsViewModel: Cancelable {
    
    let pet: Pet
    var medicalRecords: [MedicalRecordItem] = []
    
    init(medicalRecords: [MedicalRecordItem] = [], pet: Pet) {
        print("init", "MedicalRecordsViewModel")
        self.medicalRecords = medicalRecords
        self.pet = pet
    }
    
    func fetchMedicalRecords() {
    }
    
    func delete(at offsets: IndexSet) {
        // delete the objects here
    }
    
}

@Observable class MedicalRecordsDataViewModel: MedicalRecordsViewModel {
    
    let dataSource: DataSource
    
    init(dataSource: DataSource, pet: Pet) {
        self.dataSource = dataSource
        print("init", "MedicalRecordsDataViewModel")
        super.init(pet: pet)
        
        fetchMedicalRecords()
        assignListeners()
    }
    
    private func assignListeners() {
        NotificationManager.shared.publishersFor([.medicalRecordAdded, .medicalRecordUpdated])
            .forEach { publisher in
                publisher
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        self?.fetchMedicalRecords()
                    }
                    .store(in: &cancelable)
            }
    }

    
    override func fetchMedicalRecords() {
        do {
            let petId = pet.id
            medicalRecords = try dataSource.fetch(type: MedicalRecordItem.self, predicate: #Predicate { medicalRecord in
                medicalRecord.petId == petId
            })
        } catch {
            // TODO:
            print(error)
        }
    }
    
    override func delete(at offsets: IndexSet) {
        let items = offsets.map { medicalRecords[$0] }
        items.forEach {
            dataSource.delete($0)
            let notificationData = try? MedicalRecordNotificationId(id: $0.id, petId: $0.petId).dictionary()
            NotificationManager.shared.postNotification(.medicalRecordDeleted, data: notificationData)
        }
        
    }
    
}

