//
//  DashboardViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI

@Observable class DashboardViewModel {
    
    var scrollPosition: Int? = 1
    var dashboardItem: DashboardItem {
        DashboardItem.item(for: scrollPosition ?? DashboardItem.home.scrollPosition)
    }
    
    let dataService: DataService
    
    init(dataService: DataService) {
        print("init", "DashboardViewModel")
        self.dataService = dataService
    }
    
    enum DashboardItem: CaseIterable, Identifiable {
        
        var id: Self { self }
        
        case events
        case home
        case settings
        
        static func item(for scrollPosition: Int) -> Self {
            return DashboardItem.allCases.first(where: { $0.scrollPosition == scrollPosition }) ?? .home
        }
        
        var scrollPosition: Int {
            switch self {
            case .events: 0
            case .home: 1
            case .settings: 2
            }
        }
        
        var image: Image {
            switch self {
            case .events: SystemIcon.systemIconBellFill.image
            case .home: Image(.logoMascot).renderingMode(.template)//SystemIcon.systemIconHouse.image
            case .settings: SystemIcon.systemIconGearFill.image
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

