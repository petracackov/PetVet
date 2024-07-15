//
//  Navigation.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI

class Navigation: ObservableObject {

    @Published var navigationPath = NavigationPath()
    
    
    enum PetPath: Hashable {
        case reminders
        case editPet
        case medicalRecords
        case addMedicalRecord
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
    
}
