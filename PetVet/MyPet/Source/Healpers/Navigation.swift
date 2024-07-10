//
//  Navigation.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI
import SwiftData

@Observable class Navigation {
    
    static let shared = Navigation()
    
    var navigationPath = NavigationPath()
    
    enum Path: Hashable {
        case pet(Pet)
        case medicalRecords(pet: Pet)
        case reminders(pet: Pet)
        case manageMedicalRecord(medicalRecord: MedicalRecordItem?, pet: Pet)
        case managePet(Pet?)
    }
    
}
