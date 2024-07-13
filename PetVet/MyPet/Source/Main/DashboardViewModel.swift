//
//  DashboardViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI

@Observable class DashboardViewModel {
    
    var dashboardView: DashboardItem = .home
    let dataSource: DataSource
    
    init(dataSource: DataSource) {
        print("init", "DashboardViewModel")
        self.dataSource = dataSource
    }
    
    enum DashboardItem {
        case events
        case home
        case settings
        
        var image: Image {
            switch self {
            case .events: .systemIconBell
            case .home: .systemIconHouse
            case .settings: .systemIconGear
            }
        }
        
        var title: String {
            switch self {
            case .events: "Reminders"
            case .home: "Home"
            case .settings: "Settings"
            }
        }
    }
    
}

