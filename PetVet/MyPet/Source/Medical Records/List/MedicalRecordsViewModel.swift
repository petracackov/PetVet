//
//  MedicalRecordsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 2. 7. 24.
//

import SwiftData
import SwiftUI

@Observable class MedicalRecordsViewModel {
    
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
    
    let modelContext: ModelContext
    
    init(modelContext: ModelContext, pet: Pet) {
        self.modelContext = modelContext
        print("init", "MedicalRecordsDataViewModel")
        super.init(pet: pet)
        
        fetchMedicalRecords()
        addObservers()
    }
    
    private func addObservers() {
        NotificationManager.shared.addObserverFor(.medicalRecordAdded, selector: #selector(updateData))
        NotificationManager.shared.addObserverFor(.medicalRecordDeleted, selector: #selector(updateData))
        NotificationManager.shared.addObserverFor(.medicalRecordUpdated, selector: #selector(updateData))
    }
    
    @objc func updateData() {
        fetchMedicalRecords()
    }
    
    override func fetchMedicalRecords() {
        do {
            let petId = pet.id
            let medicalRecordsDescriptor = FetchDescriptor<MedicalRecordItem>(predicate: #Predicate { medicalRecord in
                medicalRecord.petId == petId
            })
            medicalRecords = try modelContext.fetch(medicalRecordsDescriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    override func delete(at offsets: IndexSet) {
        let items = offsets.map { medicalRecords[$0] }
        items.forEach {
            modelContext.delete($0)
            let notificationData = try? MedicalRecordNotificationId(id: $0.id, petId: $0.petId).dictionary()
            NotificationManager.shared.postNotification(.medicalRecordDeleted, data: notificationData)
        }
        
    }
    
}

