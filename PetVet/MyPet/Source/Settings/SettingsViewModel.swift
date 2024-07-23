//
//  SettingsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 11. 7. 24.
//

import Foundation

@Observable class SettingsViewModel {
    
    let dataService: DataService
    
    init(dataService: DataService) {
        print("init", "SettingsViewModel")
        self.dataService = dataService
    }
    
}
