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
        Pet(id: UUID().uuidString, name: "Dog", species: .dog, image: .nacho, gender: .male, birthDate: Date()),
        Pet(id: UUID().uuidString, name: "Unknown", species: .unknown, image: .nacho, gender: .unknown, birthDate: Date().addingTimeInterval(-6543)),
    ]
    
    static func getMyPets() async -> [Pet] {
        return pets
    }
    
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
    
    static func getMedicalRecords() async -> [MedicalRecordItem] {
        return medicalRecords
    }
    
}
