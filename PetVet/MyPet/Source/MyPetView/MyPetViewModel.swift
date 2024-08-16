//
//  MyPetViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 28. 6. 24.
//

import SwiftUI
import Combine

@Observable class MyPetViewModel: ViewModel {
    
    let dataService: DataService
    private(set) var pet: Pet
    private(set) var medicalRecords: [MedicalRecordItem] = []
    private(set) var events: [PetEvent] = []
    
    /// For preview
    init(dataService: DataService, pet: Pet, medicalRecords: [MedicalRecordItem], events: [PetEvent]) {
        print("init", "MyPetViewModel")
        self.dataService = dataService
        self.medicalRecords = medicalRecords
        self.pet = pet
        self.events = events
        super.init()
        
    }
    
    /// Fetches the data and assigns listeners
    convenience init(dataService: DataService, pet: Pet) {
        print("init", "MyPetViewModel")
        self.init(dataService: dataService, pet: pet, medicalRecords: [], events: [])
        self.assignListeners()
        self.fetchMyPetsMedicalRecords()
        self.fetchMyPetsEvents()
    }
    
    private func fetchPet() {
        do {
            pet = try dataService.fetchPet(id: pet.id)
        } catch {
            handleError(error)
        }
    }
    
    private func fetchMyPetsEvents() {
        do {
            events = try dataService.fetchEvents(for: pet, fetchLimit: 3)
        } catch {
            handleError(error)
        }
    }
    
    private func fetchMyPetsMedicalRecords() {
        do {
            medicalRecords = try dataService.fetchMedicalRecords(for: pet, fetchLimit: 3)
        } catch {
            handleError(error)
        }
    }
    
    private func assignListeners() {
        NotificationManager.shared.publishersFor([.medicalRecordUpdated, .medicalRecordAdded, .medicalRecordDeleted])
            .forEach { publisher in
                publisher
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        self?.fetchMyPetsMedicalRecords()
                    }
                    .store(in: &cancelable)
            }
        
        NotificationManager.shared.publishersFor([.eventAdded, .eventDeleted, .eventUpdated])
            .forEach { publisher in
                publisher
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        self?.fetchMyPetsEvents()
                    }
                    .store(in: &cancelable)
            }
    }
    
}
