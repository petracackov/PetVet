//
//  ManageMedicalRecordViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import Foundation

@Observable class ManageMedicalRecordViewModel {
    
    private let dataSource: DataSource
    private let medicalRecord: MedicalRecordItem?
    private let pet: Pet
    var title: String
    var description: String
    var date: Date
    
    init(dataSource: DataSource, medicalRecord: MedicalRecordItem? = nil, pet: Pet) {
        print("init", "ManageMedicalRecordViewModel")
        self.dataSource = dataSource
        self.medicalRecord = medicalRecord
        self.pet = pet
        self.title = medicalRecord?.title ?? ""
        self.description = medicalRecord?.itemDescription ?? ""
        self.date = medicalRecord?.date ?? Date()
    }
    
    func save() {
        if let medicalRecord {
            medicalRecord.title = title
            medicalRecord.itemDescription = description
            medicalRecord.date = date
            let notificationData = try? MedicalRecordNotificationId(id: medicalRecord.id, petId: medicalRecord.petId).dictionary()
            NotificationManager.shared.postNotification(.medicalRecordUpdated, data: notificationData)
        } else if !description.isEmpty, !title.isEmpty {
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
