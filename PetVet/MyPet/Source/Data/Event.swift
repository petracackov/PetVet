//
//  Event.swift
//  MyPet
//
//  Created by Petra Cackov on 15. 7. 24.
//

import Foundation
import SwiftData

@Model
class PetEvent: Identifiable {
    
    @Attribute(.unique) let id: String
    var title: String
    var eventDescription: String
    var date: Date
//    let petId: String
    var completed: Bool
    var pet: Pet
    
    init(id: String, title: String, eventDescription: String, date: Date, completed: Bool, pet: Pet) {
        self.id = id
        self.title = title
        self.eventDescription = eventDescription
        self.date = date
//        self.petId = petId
        self.completed = completed
        self.pet = pet
    }
    
}
