//
//  ManageMedicalRecordViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import Foundation

@Observable class ManageMedicalRecordViewModel {
    
    private let dataService: DataService
    private let medicalRecord: MedicalRecordItem?
    private let pet: Pet
    var title: String
    var description: String
    var date: Date
    
    var isEditing: Bool {
        medicalRecord != nil
    }
    
    init(dataService: DataService, medicalRecord: MedicalRecordItem? = nil, pet: Pet) {
        print("init", "ManageMedicalRecordViewModel")
        self.dataService = dataService
        self.medicalRecord = medicalRecord
        self.pet = pet
        self.title = medicalRecord?.title ?? ""
        self.description = medicalRecord?.itemDescription ?? ""
        self.date = medicalRecord?.date ?? Date()
    }
    
    func save() {
        if let medicalRecord {
            dataService.updateMedicalRecord(medicalRecord, title: title, description: description, date: date)
        } else if !description.isEmpty, !title.isEmpty {
            dataService.createMedicalRecord(for: pet, title: title, description: description, date: date)
        } else {
            AppError.handle(NSError())
        }
    }
    
    func deleteMedicalRecord() {
        guard let medicalRecord else { return }
        dataService.deleteMedicalRecord(medicalRecord)
    }
    
}
