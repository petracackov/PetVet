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
    
    
    enum PetPath: Hashable {
        case reminders
        case editPet
        case medicalRecords
    }
    
    enum MedicalRecordsPath: Hashable {
        case addMedicalRecord
        case editMedicalRecord(MedicalRecordItem)
    }
    
    enum MyPetsPath: Hashable {
        case pet(Pet)
        case createNewPet
    }
    
    enum SettingsPath {
        case addNewPet
    }
    
//    enum Path: Hashable {
//        case pet(Pet)
//        case medicalRecords(pet: Pet)
//        case reminders(pet: Pet)
//        case manageMedicalRecord(medicalRecord: MedicalRecordItem?, pet: Pet)
//        case managePet(Pet?)
//    }
    
}
