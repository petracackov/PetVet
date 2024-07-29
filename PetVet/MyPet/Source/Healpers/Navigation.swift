//
//  Navigation.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI

@Observable class Navigation {

    var navigationPath = NavigationPath()
    var tabBarIsHidden: Bool = false
    
    static var shared = Navigation()
    
    enum PetPath: Hashable {
        case reminders
        case editPet
        case medicalRecords
        case addMedicalRecord
        case addReminder
    }
    
    enum MedicalRecordsPath: Hashable {
        case addMedicalRecord
        case editMedicalRecord(MedicalRecordItem)
    }
    
    enum EventsPath: Hashable {
        case addEvent(Pet)
        case manageEvent(PetEvent)
    }
    
    enum MyPetsPath: Hashable {
        case pet(Pet)
        case createNewPet
    }
    
    enum SettingsPath {
        case addNewPet
    }
    
}
