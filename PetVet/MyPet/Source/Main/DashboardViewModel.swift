//
//  DashboardViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI
import SwiftData

@Observable class DashboardViewModel {
    
    var dashboardView: DashboardItem = .home
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        print("init", "DashboardViewModel")
        self.modelContext = modelContext
    }
    
    enum DashboardItem {
        case events
        case home
        case settings
        
        var image: Image {
            switch self {
            case .events: Image(systemName: "bell")
            case .home: Image(systemName: "house")
            case .settings: Image(systemName: "gearshape")
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

