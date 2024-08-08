//
//  ManageMedicalRecordViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import Foundation

@Observable class ManageMedicalRecordViewModel: ViewModel {
    
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
        do {
            if let medicalRecord, !description.isEmpty, !title.isEmpty {
                dataService.updateMedicalRecord(medicalRecord, title: title, description: description, date: date)
            } else if !description.isEmpty, !title.isEmpty {
                try dataService.createMedicalRecord(for: pet, title: title, description: description, date: date)
            } else {
                handleError(.validationFailed)
            }
        } catch {
            handleError(error)
        }
    }
    
    func deleteMedicalRecord() {
        guard let medicalRecord else { return }
        do {
            try dataService.deleteMedicalRecord(medicalRecord)
        } catch {
            handleError(error)
        }
    }
    
}
