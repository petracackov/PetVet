//
//  SettingsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 11. 7. 24.
//

import Foundation

@Observable class SettingsViewModel {
    
}

@Observable class SettingsDataViewModel: SettingsViewModel {
    
    let dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
}
