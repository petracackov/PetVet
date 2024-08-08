//
//  DataService.swift
//  MyPet
//
//  Created by Petra Cackov on 23. 7. 24.
//

import UIKit

class DataService {
    
    let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func fetchEvents(for pet: Pet? = nil, fetchLimit: Int? = nil) throws -> [PetEvent] {
        if let pet {
            let petId = pet.id
            return try dataSource.fetch(type: PetEvent.self,
                                        fetchLimit: fetchLimit,
                                        predicate: #Predicate { event in event.pet.id == petId },
                                        sortBy: [SortDescriptor(\.date)])
        } else {
            return try dataSource.fetch(type: PetEvent.self,
                                        fetchLimit: fetchLimit,
                                        sortBy: [SortDescriptor(\.date)])
        }
    }
    
    func deleteEvent(_ event: PetEvent) throws {
        try dataSource.delete(event)
        let notificationData = try? EventNotificationId(id: event.id, petId: event.pet.id).dictionary()
        NotificationManager.shared.postNotification(.eventDeleted, data: notificationData)
    }
    
    func updateEvent(_ event: PetEvent, title: String, description: String, date: Date, completed: Bool) {
        event.title = title
        event.eventDescription = description
        event.date = date
        event.completed = completed
        let notificationData = EventNotificationId(id: event.id, petId: event.pet.id)
        NotificationManager.shared.postNotification(.eventUpdated, data: try? notificationData.dictionary())
    }
    
    func createEvent(for pet: PetEvent.PetInfo, title: String, description: String, date: Date, completed: Bool) throws {
        let id = UUID().uuidString
        let event = PetEvent(id: id, title: title, eventDescription: description, date: date, pet: pet, completed: completed)
        try dataSource.insert(event)
        let notificationData = PetNotificationId(id: id)
        NotificationManager.shared.postNotification(.eventAdded, data: try? notificationData.dictionary())
    }
    
    func fetchMyPets() throws -> [Pet] {
        return try dataSource.fetch(type: Pet.self, sortBy: [SortDescriptor(\.name)])
    }
    
    func fetchPet(id: String) throws -> Pet {
        let petId = id
        let pets = try dataSource.fetch(type: Pet.self, predicate: #Predicate { pet in
            pet.id == petId
        })
        if let pet = pets.first {
            return pet
        } else {
            throw AppError.noData
        }
    }
    
    func createPet(name: String, species: Pet.Species, image: UIImage?, gender: Pet.Gender, birthDate: Date) throws {
        // TODO: update all events with correct edited name
        let id = UUID().uuidString
        let pet = Pet(id: id, name: name, species: species, image: image, gender: gender, birthDate: birthDate)
        try dataSource.insert(pet)
        let notificationData = PetNotificationId(id: id)
        NotificationManager.shared.postNotification(.petAdded, data: try? notificationData.dictionary())
    }
    
    func updatePet(_ pet: Pet, name: String, species: Pet.Species, image: UIImage?, birthDate: Date) {
        pet.name = name
        pet.species = species
        pet.image = image
        pet.birthDate = birthDate
        let notificationData = PetNotificationId(id: pet.id)
        NotificationManager.shared.postNotification(.petUpdated, data: try? notificationData.dictionary())
    }
    
    func deletePet(_ pet: Pet) throws {
        try dataSource.delete(pet)
        let notificationData = PetNotificationId(id: pet.id)
        NotificationManager.shared.postNotification(.petDeleted, data: try? notificationData.dictionary())
    }
    
    func fetchMedicalRecords(for pet: Pet, fetchLimit: Int? = nil) throws -> [MedicalRecordItem] {
        let petId = pet.id
        return try dataSource.fetch(type: MedicalRecordItem.self, fetchLimit: fetchLimit, predicate: #Predicate { medicalRecord in
            medicalRecord.petId == petId
        })
    }
    
    func createMedicalRecord(for pet: Pet, title: String, description: String, date: Date) throws {
        let medicalRecord = MedicalRecordItem(title: title, itemDescription: description, petId: pet.id, date: date)
        try dataSource.insert(medicalRecord)
        let notificationData = try? MedicalRecordNotificationId(id: medicalRecord.id, petId: medicalRecord.petId).dictionary()
        NotificationManager.shared.postNotification(.medicalRecordAdded, data: notificationData)
    }
    
    func updateMedicalRecord(_ medicalRecord: MedicalRecordItem, title: String, description: String, date: Date) {
        medicalRecord.title = title
        medicalRecord.itemDescription = description
        medicalRecord.date = date
        let notificationData = try? MedicalRecordNotificationId(id: medicalRecord.id, petId: medicalRecord.petId).dictionary()
        NotificationManager.shared.postNotification(.medicalRecordUpdated, data: notificationData)
    }
    
    func deleteMedicalRecord(_ medicalRecord: MedicalRecordItem) throws {
        let notificationData = try? MedicalRecordNotificationId(id: medicalRecord.id, petId: medicalRecord.petId).dictionary()
        try dataSource.delete(medicalRecord)
        NotificationManager.shared.postNotification(.medicalRecordDeleted, data: notificationData)
    }
    
}
