//
//  SettingsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 11. 7. 24.
//

import Foundation
import SwiftData

@Observable class SettingsViewModel {
    
}

@Observable class SettingsDataViewModel: SettingsViewModel {
    
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
}
