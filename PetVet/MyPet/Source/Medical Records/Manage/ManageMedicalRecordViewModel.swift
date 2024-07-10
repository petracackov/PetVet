//
//  ManageMedicalRecordViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import Foundation
import SwiftData

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
    
    let modelContext: ModelContext
    
    init(modelContext: ModelContext, medicalRecord: MedicalRecordItem?, pet: Pet) {
        self.modelContext = modelContext
        
        print("init", "ManageMedicalRecordDataViewModel")
        super.init(medicalRecord: medicalRecord, pet: pet)
    }
    
    override func save() {
        if let medicalRecord {
            medicalRecord.title = title
            medicalRecord.itemDescription = description
            medicalRecord.date = date
        } else if !description.isEmpty,  !title.isEmpty {
            let medicalRecord = MedicalRecordItem(title: title, itemDescription: description, petId: pet.id, date: date)
            modelContext.insert(medicalRecord)
            
        } else {
            // TODO: handle error
            print("No data error")
        }
    }
    
}

