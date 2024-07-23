//
//  MockedData.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import Foundation

class MockedData {
    
    static let pets = [
        Pet(id: UUID().uuidString, name: "Cat", species: .cat, image: .nacho, gender: .female, birthDate: Date().addingTimeInterval(-12345)),
        Pet(id: UUID().uuidString, name: "Dog", species: .dog, image: nil, gender: .male, birthDate: Date()),
        Pet(id: UUID().uuidString, name: "Unknown", species: .unknown, image: .nacho, gender: .unknown, birthDate: Date().addingTimeInterval(-6543)),
    ]
    
    static let medicalRecords = [
        MedicalRecordItem(id: UUID().uuidString, 
                          title: "Medical record 1",
                          itemDescription: "Medical record,\nMedical record ,Medical record",
                          petId: "1",
                         date: Date()),
        MedicalRecordItem(id: UUID().uuidString,
                          title: "Medical record 2",
                          itemDescription: "Medical record",
                          petId: "1",
                          date: Date().addingTimeInterval(10000000)),
        MedicalRecordItem(id: UUID().uuidString,
                          title: "Medical record 3",
                          itemDescription: "Medical record,\nMedical record\n,Medical record",
                          petId: "1",
                          date: Date().addingTimeInterval(20077700000)),
        MedicalRecordItem(id: UUID().uuidString,
                          title: "Medical record 4",
                          itemDescription: "Medical record,\n Medical record, Medical record",
                          petId: "1",
                          date: Date()),
        MedicalRecordItem(id: UUID().uuidString,
                          title: "Medical record 5",
                          itemDescription: "Medical record,\n Medical record ,Medical record",
                          petId: "1",
                          date: Date())
    ]
    
    static let events: [PetEvent] = [
        PetEvent(id: UUID().uuidString, title: "Event1", eventDescription: "Event1", date: Date(), pet: eventPets[0], completed: true),
        PetEvent(id: UUID().uuidString, title: "Event2", eventDescription: "Event2, Event2, Event2\n Event2", date: Date().addingTimeInterval(-1234567), pet: eventPets[1], completed: true),
        PetEvent(id: UUID().uuidString, title: "Event3", eventDescription: "Event3", date: Date().addingTimeInterval(-12345), pet: eventPets[2], completed: false),
        PetEvent(id: UUID().uuidString, title: "Event4", eventDescription: "Event4", date: Date().addingTimeInterval(12345), pet: eventPets[3], completed: true),
        PetEvent(id: UUID().uuidString, title: "Event5", eventDescription: "Event5", date: Date().addingTimeInterval(34567), pet: eventPets[4], completed: false)
    ]
    
    static let eventPets: [PetEvent.PetInfo] = [
        .init(id: UUID().uuidString, name: "pet"),
        .init(id: UUID().uuidString, name: "pet long name"),
        .init(id: UUID().uuidString, name: "pe"),
        .init(id: UUID().uuidString, name: "pet really long name"),
        .init(id: UUID().uuidString, name: "pet"),
    ]
    
}
