//
//  MedicalRecordsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 2. 7. 24.
//

import SwiftUI

@Observable class MedicalRecordsViewModel: Cancelable {
    
    let dataService: DataService
    let pet: Pet
    var medicalRecords: [MedicalRecordItem] = []
    
    /// For preview
    init(dataService: DataService, medicalRecords: [MedicalRecordItem], pet: Pet) {
        print("init", "MedicalRecordsViewModel")
        self.dataService = dataService
        self.medicalRecords = medicalRecords
        self.pet = pet
        
        super.init()
    }
    
    /// Fetches the data and assigns listeners
    convenience init(dataService: DataService, pet: Pet) {
        self.init(dataService: dataService, medicalRecords: [], pet: pet)
        
        assignListeners()
        fetchMedicalRecords()
    }
    
    private func assignListeners() {
        NotificationManager.shared.publishersFor([.medicalRecordAdded, .medicalRecordUpdated, .medicalRecordDeleted])
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
            medicalRecords = try dataService.fetchMedicalRecords(for: pet)
        } catch {
            AppError.handle(error)
        }
    }
    
    func delete(at offsets: IndexSet) {
        let items = offsets.map { medicalRecords[$0] }
        items.forEach {
            dataService.deleteMedicalRecord($0)
        }
        
    }
    
}


