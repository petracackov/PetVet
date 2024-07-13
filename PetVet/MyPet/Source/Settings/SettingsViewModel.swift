//
//  SettingsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 11. 7. 24.
//

import Foundation

@Observable class SettingsViewModel {
    
    let dataSource: DataSource
    
    init(dataSource: DataSource) {
        print("init", "SettingsViewModel")
        self.dataSource = dataSource
    }
    
}
