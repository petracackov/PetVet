//
//  MedicalRecordItem.swift
//  MyPet
//
//  Created by Petra Cackov on 28. 6. 24.
//

import SwiftData
import Foundation

@Model
class MedicalRecordItem: Identifiable, Equatable {
    
    @Attribute(.unique) let id: String
    var title: String
    var itemDescription: String
    let petId: String
    var date: Date
    
    init(id: String = UUID().uuidString, title: String, itemDescription: String, petId: String, date: Date) {
        self.id = id
        self.title = title
        self.itemDescription = itemDescription
        self.petId = petId
        self.date = date
    }
    
}

