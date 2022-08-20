//
//  Event.swift
//  PetVet
//
//  Created by Petra Cackov on 02/07/2022.
//

import Foundation

class Event: Identifiable, Equatable {

    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }

    let id: String
    let title: String
    let description: String
    let petId: String
    let pet: Pet
    let eventDate: Date
    let completed: Bool

    init(id: String = UUID().uuidString, title: String, description: String, petId: String, pet: Pet, eventDate: Date, completed: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.petId = petId
        self.pet = pet
        self.eventDate = eventDate
        self.completed = completed
    }

    static func getEvents() async throws -> [Event] {
        return [
            Event(title: "Rabies", description: "vacination", petId: "123", pet: Pet(name: "Nacho", ownerId: "123", gender: .male, dateOfBirth: Date(), type: .cat), eventDate: Date(), completed: false),
            Event(title: "Rabies", description: "vacination", petId: "123", pet: Pet(name: "Nacho", ownerId: "123", gender: .male, dateOfBirth: Date(), type: .cat), eventDate: Date(), completed: false),
            Event(title: "Rabies", description: "vacination", petId: "123", pet: Pet(name: "Nacho", ownerId: "123", gender: .male, dateOfBirth: Date(), type: .cat), eventDate: Date(), completed: false),
            Event(title: "Rabies", description: "vacination", petId: "123", pet: Pet(name: "Nacho", ownerId: "123", gender: .male, dateOfBirth: Date(), type: .cat), eventDate: Date(), completed: false),
            Event(title: "Rabies", description: "vacination", petId: "123", pet: Pet(name: "Nacho", ownerId: "123", gender: .male, dateOfBirth: Date(), type: .cat), eventDate: Date(), completed: false),
            Event(title: "Rabies", description: "vacination", petId: "123", pet: Pet(name: "Nacho", ownerId: "123", gender: .male, dateOfBirth: Date(), type: .cat), eventDate: Date(), completed: false),
            Event(title: "Rabies", description: "vacination", petId: "123", pet: Pet(name: "Nacho", ownerId: "123", gender: .male, dateOfBirth: Date(), type: .cat), eventDate: Date(), completed: false),
            Event(title: "Rabies", description: "vacination", petId: "123", pet: Pet(name: "Nacho", ownerId: "123", gender: .male, dateOfBirth: Date(), type: .cat), eventDate: Date(), completed: false),
            Event(title: "Rabies", description: "vacination", petId: "123", pet: Pet(name: "Nacho", ownerId: "123", gender: .male, dateOfBirth: Date(), type: .cat), eventDate: Date(), completed: false),
            Event(title: "Rabies", description: "vacination", petId: "123", pet: Pet(name: "Nacho", ownerId: "123", gender: .male, dateOfBirth: Date(), type: .cat), eventDate: Date(), completed: false)
        ]
    }
}
