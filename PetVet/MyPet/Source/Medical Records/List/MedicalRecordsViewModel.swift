//
//  MedicalRecordsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 2. 7. 24.
//

import SwiftUI

@Observable class MedicalRecordsViewModel: Cancelable {
    
    let dataSource: DataSource
    let pet: Pet
    var medicalRecords: [MedicalRecordItem] = []
    
    /// For preview
    init(dataSource: DataSource, medicalRecords: [MedicalRecordItem], pet: Pet) {
        print("init", "MedicalRecordsViewModel")
        self.dataSource = dataSource
        self.medicalRecords = medicalRecords
        self.pet = pet
        
        super.init()
    }
    
    /// Fetches the data and assigns listeners
    convenience init(dataSource: DataSource, pet: Pet) {
        self.init(dataSource: dataSource, medicalRecords: [], pet: pet)
        
        assignListeners()
        fetchMedicalRecords()
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

    
    private func fetchMedicalRecords() {
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
    
    func delete(at offsets: IndexSet) {
        let items = offsets.map { medicalRecords[$0] }
        items.forEach {
            dataSource.delete($0)
            let notificationData = try? MedicalRecordNotificationId(id: $0.id, petId: $0.petId).dictionary()
            NotificationManager.shared.postNotification(.medicalRecordDeleted, data: notificationData)
        }
        
    }
    
}


