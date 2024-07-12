//
//  ManageMedicalRecordViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import Foundation

@Observable class ManageMedicalRecordViewModel {
    
    var medicalRecord: MedicalRecordItem?
    private(set) var pet: Pet
    var title: String
    var description: String
    var date: Date
    
    init(medicalRecord: MedicalRecordItem?, pet: Pet) {
        print("init", "ManageMedicalRecordViewModel")
        self.medicalRecord = medicalRecord
        self.pet = pet
        self.title = medicalRecord?.title ?? ""
        self.description = medicalRecord?.itemDescription ?? ""
        self.date = medicalRecord?.date ?? Date()
    }
    
    func save() {
        
    }
    
}

@Observable class ManageMedicalRecordDataViewModel: ManageMedicalRecordViewModel {
    
    let dataSource: DataSource
    
    init(dataSource: DataSource, medicalRecord: MedicalRecordItem?, pet: Pet) {
        self.dataSource = dataSource
        
        print("init", "ManageMedicalRecordDataViewModel")
        super.init(medicalRecord: medicalRecord, pet: pet)
    }
    
    override func save() {
        if let medicalRecord {
            medicalRecord.title = title
            medicalRecord.itemDescription = description
            medicalRecord.date = date
            let notificationData = try? MedicalRecordNotificationId(id: medicalRecord.id, petId: medicalRecord.petId).dictionary()
            NotificationManager.shared.postNotification(.medicalRecordUpdated, data: notificationData)
        } else if !description.isEmpty,  !title.isEmpty {
            let medicalRecord = MedicalRecordItem(title: title, itemDescription: description, petId: pet.id, date: date)
            dataSource.insert(medicalRecord)
            let notificationData = try? MedicalRecordNotificationId(id: medicalRecord.id, petId: medicalRecord.petId).dictionary()
            NotificationManager.shared.postNotification(.medicalRecordAdded, data: notificationData)
        } else {
            // TODO: handle error
            print("No data error")
        }
    }
    
}

