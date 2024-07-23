//
//  Event.swift
//  MyPet
//
//  Created by Petra Cackov on 15. 7. 24.
//

import Foundation
import SwiftData

@Model
class PetEvent: Identifiable, Hashable {
    
    @Attribute(.unique) let id: String
    var title: String
    var eventDescription: String
    var date: Date
    let pet: PetInfo
    var completed: Bool
    
    init(id: String, title: String, eventDescription: String, date: Date, pet: PetInfo, completed: Bool) {
        self.id = id
        self.title = title
        self.eventDescription = eventDescription
        self.date = date
        self.pet = pet
        self.completed = completed
    }
    
    struct PetInfo: Codable, Hashable, Identifiable {
        let id: String
        let name: String
        
        init(id: String, name: String) {
            self.id = id
            self.name = name
        }
        
        init(pet: Pet) {
            self.id = pet.id
            self.name = pet.name
        }
    }
    
}
